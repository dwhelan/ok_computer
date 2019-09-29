defmodule OkComputer.Railroad do
  defmacro defrailroad() do
    quote do
      defmacro left ~> right do
        quote do
          unquote(left)
          |> ok_monad().bind(fn value ->
            unquote(Macro.pipe(left, right, 0))
          end)
        end
      end

      defmacro left ~>> right do
        quote do
          unquote(left)
          |> error_monad().bind(fn value ->
            unquote(Macro.pipe(left, right, 0))
          end)
        end
      end

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
