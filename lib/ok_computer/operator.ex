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
  def a op b, do: a - b
  end
  ```

  Operators are creating by embedding source code for each operator definition into a module, compiling the module and importing it.

  The source code is simply a string version of what you would provide for a macro.
  The AST for the left hand side of the operator is available as
  as `left` and the AST for the right hand side is available as `right`.

  We can now create a dynamic pipe:

  ```
  defmodule WrongMath do
    import OkComputer.Operator

    defoperators +: "unquote(left) - unquote(right)"
  end
  ```

  This is equivalent to:

  ```
  defmodule WrongMath do
    defmacro left + right do
      quote do
        unquote(left) - unquote(right)
      end
    end
  end
  ```
  """

  @doc """
  Builds a module with operators and imports it.
  """
  defmacro operators(bindings) do
    create_operators_module(bindings, Module.concat(__CALLER__.module, Operators))
  end

  @doc """
  Builds an operators module returns the AST to import it.
  """
  def create_operators_module(bindings, module) do
    Code.compile_string(~s[
      defmodule #{module} do
        #{create_operator_macros(bindings)}
      end
    ])

    quote do
      import unquote(module)
    end
  end

  defp create_operator_macros(bindings) do
    Enum.map(bindings, &create_operator_macro/1)
  end

  defp create_operator_macro({atom, {alias, function_name}}) when is_atom(function_name) do
    module = Macro.expand(alias, __ENV__)
    ~s[
        require #{module}

        defmacro left #{atom} right do
          #{module}.#{function_name}(left, right)
        end
    ]
  end
end
