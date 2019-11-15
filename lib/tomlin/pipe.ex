defmodule OkComputer.Pipe do
  @callback pipe?(any) :: boolean

  defmacro pipes(list) do
    _pipes(list)
  end

  def _pipes(list) do
    list = Enum.map(list, fn {name, f} -> {name, operator_function(f) }end)
    Lily.Operator.create(:defmacro, list)
  end

  defmacro pipe(name, f) do
    create(name, f)
  end

  def create(name, f) do
    Lily.Operator.create(:defmacro, name, operator_function(f))
  end

  defp operator_function(f) do
    quote do
      fn left, right ->
        f = unquote(f)
        quote do
          apply(unquote(f), [unquote(left), fn left -> left |> unquote(right) end])
        end
      end
    end
  end
end
