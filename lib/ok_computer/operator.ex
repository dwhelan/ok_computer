defmodule OkComputer.Operator do
  @moduledoc """
  Creates operator macros.

  ## Operator functions
  Operator functions are used to perform binary operations.
  Operator functions take two quoted arguments and return a quoted expression.

  The following Math module has `plus` and `minus` operator functions:
  ```
  defmodule Math do
    def plus(a, b) do
      quote do
        unquote(a) + unquote(b)
      end
    end

    def minus(a, b) do
      quote do
        unquote(a) - unquote(b)
      end
    end
  end
  ```

  ## Creating operators
  Use the `operators/2` macro to create and import binary operators.
  ```
  defmodule MyModule
    import OkComputer.Operator

    operators Math, plus: :+, minus: :-

    1 + 1 # > 2
    3 - 2 # > 1
  end
  ```
  """

  @doc """
  Creates operators in a new module and imports it.

  The operator module will be created using `module/2` with the callers environment.
  Operators will be created using `create/3`.
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

  `target` should be an existing module with operator functions that you want to use.
  `bindings` should be a keyword list where each key is the name of
  an operator function in `target` and each value is the operator atom
  to use.

  A module named `module` will be created with a binary operator for each binding.
  """
  @spec create(module, keyword(atom), module) :: {:module, module(), binary(), term()}
  def create(target, bindings, module) do
    [{_, byte_code}] = Code.compile_string(~s[
      defmodule #{module} do
        #{Enum.map(bindings, &create_operator(target, &1))}
      end
    ])
    {:module, module, byte_code, nil}
  end

  defp create_operator(target, {_, operator} = binding) do
    cond do
      Macro.operator?(operator, 2) -> create_binary_operator(target, binding)
      Macro.operator?(operator, 1) -> create_unary_operator(target, binding)
    end
  end

  defp create_unary_operator(target, {function_name, operator}) do
    IO.inspect m: "unary", target: target, operator: operator
    ~s[
        require #{target}

        defmacro #{operator} input do
          #{target}.#{function_name}(input)
        end
    ]
  end

  defp create_binary_operator(target, {function_name, operator}) do
    ~s[
        require #{target}

        defmacro left #{operator} right do
          #{target}.#{function_name}(left, right)
        end
    ]
  end

  @doc """
  Returns the operator module to use for `target`.

  It will return the concatenation of `env.module`, `Operator` and the last part of `target`.
  """
  @spec module(module, Macro.Env.t()) :: module
  def module(target, env) do
    Module.concat([env.module, Operator, Module.split(target) |> List.last()])
  end
end
