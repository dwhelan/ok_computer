defmodule OkComputer.Pipe do
  @callback pipe?(any) :: boolean

  defmacro defpipes(list) do
    pipes(list)
  end

  def pipes(list) do
    list
    |> Enum.map(fn {name, f} -> {name, operator_function(f)} end)
    |> Lily.Operator.create(:defmacro)
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
