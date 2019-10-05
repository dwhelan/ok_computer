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
    monad = Macro.expand(monad, __CALLER__)
    macro_name = :"case_#{OkComputer.Monad.name(monad)}"

    quote do
      @monad unquote(monad)

      defmacro unquote(macro_name)(value, do: clauses) do
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
