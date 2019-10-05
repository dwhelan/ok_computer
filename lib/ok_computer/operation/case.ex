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
    macro_name =
      case name do
        nil -> :case_nil
        _ -> :"case_#{name}"
      end

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
