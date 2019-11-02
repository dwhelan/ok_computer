defmodule OkComputer.NewOperator do

  @operators %{
    @: At,
    +: Plus,
    ~>: TildeRight,
    ~>>: TildeRightRight
  }

  defmacro operator(atom, f) do
    create_operator(atom, f, :operator)
  end

  defmacro operator_macro(atom, f) do
    create_operator(atom, f, :operator_macro)
  end

  defp create_operator(atom, f, create_function) do
    operator = Module.concat(__MODULE__, Map.get(@operators, atom))
    arity = function_arity(f)

    if arity in operator.arity() do
      apply(operator, create_function, [f, arity])
    else
      raise "expected a function with arity in #{inspect(operator.arity())}, but got a function with arity #{
              arity
            }"
    end
  end

  defp function_arity(f) do
    {f, _} = Code.eval_quoted(f)
    {:arity, arity} = Function.info(f, :arity)
    arity
  end
end
