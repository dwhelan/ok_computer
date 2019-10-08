defmodule OkComputer.Pipe do
  @moduledoc """
  Builds pipe operations.
  """
  @doc """
  Creates ast for `monad.bind(m, fn a -> a |> f)`.
  """
  def bind_pipe(lhs, rhs, module) do
    quote do
      unquote(module).bind(unquote(lhs), fn a -> a |> unquote(rhs) end)
    end
  end

  @spec build(atom, module) :: Macro.t()
  defmacro build(pipe, module) do
    case pipe do
      :~> ->
        quote do
          defmacro lhs ~> rhs do
            OkComputer.Pipe.bind_pipe(lhs, rhs, unquote(module))
          end
        end

      :~>> ->
        quote do
          defmacro lhs ~>> rhs do
            OkComputer.Pipe.bind_pipe(lhs, rhs, unquote(module))
          end
        end
    end
  end
end
