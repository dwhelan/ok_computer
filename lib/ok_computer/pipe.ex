defmodule OkComputer.Pipe do
  @moduledoc """
  Builds pipe operations.
  """
  @doc """
  Creates ast for `monad.bind(a, fn _ -> a |> f)`.

  `f` must be an acceptable `right` for a standard pipe `|>`
  """
  def pipe(a, f, monad) do
    pipe = Macro.pipe(a, f, 0)
    quote do
      unquote(monad).bind(unquote(a), fn _ -> unquote(pipe) end)
    end
  end

  @spec build(atom, module) :: Macro.t()
  defmacro build(pipe, monad) do
    case pipe do
      :~> ->
        quote do
          defmacro a ~> f do
            OkComputer.Pipe.pipe(a, f, unquote(monad))
          end
        end

      :~>> ->
        quote do
          defmacro a ~>> f do
            OkComputer.Pipe.pipe(a, f, unquote(monad))
          end
        end
    end
  end
end
