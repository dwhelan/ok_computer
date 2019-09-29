defmodule OkComputer.Case do
  @doc """
  Case statements for ok and error values.

  `case_ok` will execute a `case` statement with ok values
  and return error values.

  `case_error` will execute a `case` statement with error values
  and return ok values.

  This may be convenient as you don't need to create `case` clauses for error values.
  If there is only one remaining clause then you can use pipes instead.
  """
  defmacro monadic_case() do
    quote do
      defmacro case_ok(value, do: clauses) do
        quote do
          unquote(value)
          |> ok_monad().bind(fn value ->
            case(value) do
              unquote(clauses)
            end
          end)
        end
      end
    end
  end
end
