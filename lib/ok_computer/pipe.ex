defmodule OkComputer.Pipe do
  @moduledoc """
  Builds pipe operations.
  """
  def pipe(left, right, monad) do
    quote do
      unquote(monad).bind(unquote(left), fn _ -> unquote(Macro.pipe(left, right, 0)) end)
    end
  end

  @spec build(atom, module) :: Macro.t()
  defmacro build(pipe, monad) do
    case pipe do
      :~> ->
        quote do
          defmacro left ~> right do
            OkComputer.Pipe.pipe(left, right, unquote(monad))
          end
        end

      :~>> ->
        quote do
          defmacro left ~>> right do
            OkComputer.Pipe.pipe(left, right, unquote(monad))
          end
        end
    end
  end
end
