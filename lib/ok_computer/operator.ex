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

  The `Operator` creatse operators dynamically. It does this
  by embedding source code for each operator definition into an overall module definition and compiling this source into a new module.

  The source code is simply a binary. You will need to access the AST of
  what is on the left of the operator and what is on the right of the operator.
  The AST for the left hand side of the operator is available as
  as `lhs` and the AST for the right hand side is available as `rhs`.

  We can now create a dynamic pipe:

  ```
  defmodule WrongMath do
    import OkComputer.Operator

    defoperators +: "unquote(lhs) - unquote(rhs)"
  end
  ```

  This is equivalent to:

  ```
  defmodule WrongMath do
    import OkComputer.Operator
    import Kernel, except: [+: 2]

    defmacro lhs + rhs do
      quote do
        unquote(lhs) - unquote(rhs)
      end
    end
  end
  ```
  """

  @doc """
  Builds a module with operators and imports it.

  The name of the module will be the caller's module followed by `.Operators`.
  """
  @spec defoperators(keyword(binary)) :: Macro.t()
  defmacro defoperators(operators) do
    defoperators(operators, Module.concat(__CALLER__.module, Operators))
  end

  @doc """
  Builds a module with operators and returns the ast to import it.

  A new module `module` will be built with the operators. provided.
  """
  @spec defoperators(keyword(binary), module) :: Macro.t()
  def defoperators(operators, module) do
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
