defmodule OkComputer.Pipe do
  @moduledoc """
  Builds monadic pipes.
  """
  @doc """
  Creates ast for `monad.bind(m, fn a -> a |> f)`.
  """
  def monadic(lhs, rhs, module, function) do
    quote do
      unquote(module).unquote(function)(unquote(lhs), fn a -> a |> unquote(rhs) end)
    end
  end

  @spec build(atom, module, atom) :: Macro.t()
  defmacro build(pipe, module, function) do
    case pipe do
      :~> ->
        quote do
          defmacro lhs ~> rhs do
            OkComputer.Pipe.monadic(lhs, rhs, unquote(module), unquote(function))
          end
        end

      :~>> ->
        quote do
          defmacro lhs ~>> rhs do
            OkComputer.Pipe.monadic(lhs, rhs, unquote(module), unquote(function))
          end
        end
    end
  end
end
