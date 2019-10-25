defmodule OkComputer.Operator do
  @moduledoc """
  Creates operator macros.

  You can easily define operator functions or macros if you know in advance the operator you want to use:

  ```elixir
  defmacro a + b do
    quote do
      unquote(a) + unquote(b)
    end
  end
  ```

  If you want a variable operator things get tricky:

  ```elixir
  op = :+

  # This won't compile:
  defmacro a op b do
    quote do
      unquote(a) + unquote(b)
    end
  end
  ```

  `operators/1` solves this problem.
  It takes an operator, a module and a function to call.
  It creates an operator macro and calls the provided function with the left and right inputs to the operator.

  For example:
  ```
  defmodule Math do
    import OkComputer.Operator

    operators +: {Functions, :plus}
  end

  defmodule Functions do
    def plus(a, b) do
      quote do
        unquote(a) + unquote(b)
      end
    end
  end
  ```

  This is equivalent to:
  ```
  defmodule Math do
    import Kernel, except: [+: 2]

    defmacro left + right do
      quote do
        unquote(left) + unquote(right)
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
