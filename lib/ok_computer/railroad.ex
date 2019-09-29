defmodule OkComputer.Railroad do
  defmacro defrailroad() do
    quote do
      import OkComputer.Pipes

      defpipes

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
