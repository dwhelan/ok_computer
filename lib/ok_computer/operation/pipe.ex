defmodule OkComputer.Operation.Pipe do
  @moduledoc """
  Builds pipe operations.
  """
  def pipe(left, right, monad) do
    quote do
      unquote(monad).bind(unquote(left), fn _ -> unquote(Macro.pipe(left, right, 0)) end)
    end
  end

  @spec build(atom, module) :: Macro.t()
  defmacro build(operator, monad) do
    case operator do
      :~> ->
        quote do
          defmacro left ~> right do
            OkComputer.Operation.Pipe.pipe(left, right, unquote(monad))
          end
        end

      :~>> ->
        quote do
          defmacro left ~>> right do
            OkComputer.Operation.Pipe.pipe(left, right, unquote(monad))
          end
        end
    end
  end
end
