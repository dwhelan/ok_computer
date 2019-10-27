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
  Creates an operator module and imports it.
  """
  @spec operators(Macro.t(), keyword(atom)) :: Macro.t()
  defmacro operators(target, bindings) do
    target = Macro.expand(target, __CALLER__)
    module = module(target, __CALLER__)

    create(target, bindings, module)

    quote do
      import unquote(module)
    end
  end

  @doc """
  Creates an operator module.
  """
  @spec create(module, keyword(atom), module) :: Macro.t()
  def create(target, bindings, module) do
    Code.compile_string(~s[
      defmodule #{module} do
        #{Enum.map(bindings, &create_operator(target, &1))}
      end
    ])
  end

  defp create_operator(target, {function_name, operator}) do
    ~s[
        require #{target}

        defmacro left #{operator} right do
          #{target}.#{function_name}(left, right)
        end
    ]
  end

  @spec module(module, Macro.Env.t()) :: module
  def module(target, env) do
    Module.concat([env.module, Operator, Module.split(target) |> List.last()])
  end
end
