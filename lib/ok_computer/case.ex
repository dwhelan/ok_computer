defmodule OkComputer.Case do
  @doc """
  A case statement that is only applied to ok values.

  If `value` is ok, then it will be pattern matched through the `case` statement and the result returned,
  otherwise `value` will be returned.

  This may be convenient as you don't need to create `case` clauses for error values.
  """
#  defmacro case_ok(value, do: clauses) do
#    quote do
#      unquote(value)
#      |> bind(fn value ->
#        case(value) do
#          unquote(clauses)
#        end
#      end)
#    end
#  end
end
