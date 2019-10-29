defmodule OkComputer.Operator do
  @moduledoc """
  Creates operators that connect to functions you provide.

  You can connect any operator to a function.
  If your function has arity two then it will be given the left and right operands.
  If it has arity one then it will be given the single operand. The function
  should return a quoted expression.

  ```
  defmodule Pipe do
    def pipe(left, right) do
      quote do
        unquote(left) |> unquote(right)
      end
    end
  end
  ```

  You connect it to an operator with the `operators/2` macro:  
  ```
  defmodule Operators do
    import OkComputer.Operator

    operators Pipe, pipe: :~>
    
    :a ~> to_string()   # "a"
  end
  ```

  You can create operators on the fly for your module only or you can create
  a module with operators to be used across modules.

  You can also do this with the `create/3` macro.
  """

  @doc """
  Creates operators in a sub-module and imports it.

  Set `target` to a module with operator functions.
  Set the `bindings` keyword using a key that is the name of an operator function
  and a value that is the operator atom to use.

  An operator sub-module will be created with a binary operator for each binding.
  The sub-module name will the last part of `targets's name.

  The sub-module will be imported.
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

  Set `target` to a module with operator functions.
  Set the `bindings` keyword using a key that is the name of an operator function
  and a value that is the operator atom to use.

  A module named `module` will be created with a binary operator for each binding.
  """
  @spec create(module, keyword(atom), module) :: {:module, module(), binary(), term()}
  def create(target, bindings, module) do
    [{_, byte_code}] =
      Code.compile_string(
        ~s[
      defmodule #{module} do
        #{
          Enum.map(
            bindings,
            fn
              {name, operator} when is_atom(operator) -> create_operator(target, {name, operator})
              {operator, [{name, arity}]} -> create_operator(target, name, arity, operator)
            end
          )
        }
      end
    ]
      )

    {:module, module, byte_code, nil}
  end

  defp create_operator(target, {name, operator}) do
    cond do
      Macro.operator?(operator, 2) -> create_operator(target, name, 2, operator)
      Macro.operator?(operator, 1) -> create_operator(target, name, 1, operator)
    end
  end

  defp create_operator(target, name, _arity = 1, operator) do
    ~s[
        require #{target}

        defmacro #{operator} input do
          #{target}.#{name}(input)
        end
    ]
  end

  defp create_operator(target, name, _arity = 2, operator) do
    ~s[
        require #{target}

        defmacro left #{operator} right do
          #{target}.#{name}(left, right)
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
