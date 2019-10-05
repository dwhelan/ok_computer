defmodule OkComputer.Operation.Case do
  @moduledoc """
  Builds case operations for monads.
  """
  alias OkComputer.Operation
  @behaviour Operation

  @doc """
  Builds a monadic `case` macro.

  Builds a macro that only invokes the
  case `clauses` when the value is accepted by the `monad`.

  The name of the macro will be `case_` with the `name` of the monad.
  """
  @spec build(module) :: Macro.t()
  defmacro build(monad) do
    name = monad |> Macro.expand(__CALLER__) |> OkComputer.Monad.name()

    quote do
      @monad unquote(monad)

      defmacro unquote(:"case_#{name}")(value, do: clauses) do
        quote do
          unquote(@monad).bind(
            unquote(value),
            fn value ->
              case(value) do
                unquote(clauses)
              end
            end
          )
        end
      end
    end
  end
end
