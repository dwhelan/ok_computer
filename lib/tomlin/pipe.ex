defmodule OkComputer.Pipe do
  @callback pipe?(any) :: boolean

  defmacro pipe(atom, f) do
    create(atom, f)
  end

  def create(atom, f) do
    Lily.Operator.create(:defmacro, atom, operator_function(f))
  end

  defp operator_function(g) do
    quote do
      fn left, right ->
        g = unquote(g)
        quote do
          apply(
            unquote(g),
            [unquote(left), fn left -> left |> unquote(right) end]
          )
        end
      end
    end
  end
end
