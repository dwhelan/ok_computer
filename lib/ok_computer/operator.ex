defmodule OkComputer.Operator do
  @moduledoc """
  Creates operators dynamically.

  You can easily define operators if you know in advance the operator you want to use:

  ```elixir
  defmodule WrongMath do
    # Let's make math wrong by changing the meaning of +:
    def a + b, do: a - b
  end
  ```

  If you want to make the operator dynamic then things are a little harder:

  ```elixir
  # This won't compile:
  op = :+
  def a unquote(op) b, do: a - b
  end
  ```

  The `Operator` module enables you to create operators dynamically. It does this
  by building Elixir source and compiling into a new module. You supply the source
  for the operator as a binary. The AST for the left hand side of the operator is available
  as `lhs` and the AST for the right hand side is available as `rhs`.

  We can now create a dynamic pipe:

  ```
  defmodule WrongMath do
    # Let's make math wrong by changing the meaning of +:
    import OkComputer.Operator
    import Kernel, except: [+: 2]

    defoperators(+: "unquote(lhs) - unquote(rhs)")
  end
  ```
  """

  @doc """
  Creates dynamic operators.

  You provide a keyword list of operator and their source and this macro will
  build the operators in a module and import the module. The name of the module
  will be the calling module appended with `.Operators`.
  """
  @spec defoperators(keyword(binary)) :: Macro.t()
  defmacro defoperators(operators) do
    __CALLER__.module
    |> Module.concat(Operators)
    |> defoperators(operators)
  end

  @doc """
  Creates dynamic operators.

  You provide a module and a keyword list of operator and their source and this macro will
  build the operators in the module.
  """
  @spec defoperators(module, keyword(binary)) :: Macro.t()
  def defoperators(module, operators) do
    Code.compile_string("""
      defmodule #{module} do
        #{Enum.map(operators, &defoperator/1)}
      end
    """)

    quote do
      import unquote(module)
    end
  end

  defp defoperator({operator, source}) do
    """
      defmacro lhs #{operator} rhs do
        quote do
          #{source}
         end
      end
    """
  end
end
