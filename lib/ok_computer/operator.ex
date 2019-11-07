defmodule OkComputer.Operator do
  @operators %{
    @: At,
    +: Plus,
    ~>: TildeRight,
    ~>>: TildeRightRight
  }

  defmacro operator(atom, f) do
    create(atom, f, :operator)
  end

  defmacro operator_macro(atom, f) do
    create(atom, f, :operator_macro)
  end

  def create(atom, f, create_function) do
    operator = Module.concat(__MODULE__, Map.get(@operators, atom))
    operator_arity = operator_arity(atom)
    arity = function_arity(f)

    if arity in operator_arity do
      apply(operator, create_function, [f, arity])
    else
      raise "expected a function with arity in #{inspect(operator_arity)}, but got a function with arity #{
              arity
            }"
    end
  end

  defp function_arity(f) do
    {f, _} = Code.eval_quoted(f)
    {:arity, arity} = Function.info(f, :arity)
    arity
  end

  def operator_arity(atom) do
    [1, 2] |> Enum.filter(fn arity -> Macro.operator?(atom, arity) end)
  end
end
