defmodule OkComputer.Operation.Case do
  @doc """
  Macros for building monadic case statements.
  """
  @spec build(atom, module) :: Macro.t()
  defmacro build(name, monad) do
    quote do
      @monad unquote(monad)
      defmacro unquote(:"case_#{name}")(value, do: clauses) do
        quote do
          unquote(value)
          |> unquote(@monad).bind(fn value ->
            case(value) do
              unquote(clauses)
            end
          end)
        end
      end
    end
  end
end
