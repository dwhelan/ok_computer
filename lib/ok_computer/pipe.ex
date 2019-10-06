defmodule OkComputer.Pipe do
  @moduledoc """
  Builds pipe operations.
  """
  @doc """
  Creates ast for `monad.bind(m, fn a -> a |> f)`.
  """
  def bind_pipe(m, f, monad) do
    quote do
      unquote(monad).bind(unquote(m), fn a -> a |> unquote(f) end)
    end
  end

  @spec build(atom, module) :: Macro.t()
  defmacro build(pipe, monad) do
    case pipe do
      :~> ->
        quote do
          defmacro m ~> f do
            OkComputer.Pipe.bind_pipe(m, f, unquote(monad))
          end
        end

      :~>> ->
        quote do
          defmacro m ~>> f do
            OkComputer.Pipe.bind_pipe(m, f, unquote(monad))
          end
        end
    end
  end
end
