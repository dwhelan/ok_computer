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
  Builds an operators module and imports it.
  """
  defmacro operators(target, bindings) do
    target = Macro.expand(target, __CALLER__)
    create(operator_module(__CALLER__.module, target), target, bindings)
  end

  @doc """
  Builds an operators module returns the AST to import it.
  """
  def create(operator_module, target, bindings) do
    Code.compile_string(~s[
      defmodule #{operator_module} do
        #{Enum.map(bindings, &create_macro(&1, target))}
      end
    ])

    quote do
      import unquote(operator_module)
    end
  end

  defp create_macro({function_name, operator}, target) when is_atom(function_name) do
    target = Macro.expand(target, __ENV__)
    ~s[
        require #{target}

        defmacro left #{operator} right do
          #{target}.#{function_name}(left, right)
        end
    ]
  end

  def operator_module(caller, target) do
    target_name = Module.split(target) |> List.last()
    operator_module = Module.concat([caller, Operator, target_name])
  end
end
