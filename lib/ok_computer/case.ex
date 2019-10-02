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
#  @spec case_(atom, module) :: Macro.t()
  defmacro case_(:ok = monad_name, monad) do
    quote do
      @spec case_ok(term, do: Macro.t()) :: Macro.t()
      defmacro unquote(:"case_#{monad_name}")(value, do: clauses) do
        quote do
          unquote(value)
          |> monad_ok().bind(fn value ->
            case(value) do
              unquote(clauses)
            end
          end)
        end
      end
    end
  end

  defmacro case_(:error = monad_name, monad) do
    quote do
      @spec case_error(term, do: Macro.t()) :: Macro.t()
      defmacro unquote(:"case_#{monad_name}")(value, do: clauses) do
        quote do
          unquote(value)
          |> monad_error().bind(fn value ->
            case(value) do
              unquote(clauses)
            end
          end)
        end
      end
    end
  end
end
