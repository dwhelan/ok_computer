defmodule OkComputer.Operation.Case do
  @moduledoc """
  Builds case operations for monads.
  """
  alias OkComputer.Operation
  @behaviour Operation

  @doc """
  Builds a `case` macro for a given monad.

  Builds a macro that only invokes the
  case `clauses` when the value is accepted by the `monad`.

  The name of the macro will be `case_` with the `name` of the monad.
  """
  @impl Operation
  @spec build(atom, module) :: Macro.t()
  defmacro build(name, monad) do
    quote do
      @monad unquote(monad)
      defmacro unquote(:"case_#{name}")(value, do: clauses) do
        quote do
          monad = unquote(@monad)
          value = unquote(value)

          monad.bind(
            value,
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
