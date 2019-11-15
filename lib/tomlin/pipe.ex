defmodule OkComputer.Pipe do
  @moduledoc """
  Support for creating pipe operators.

  A pipe consists of an operator and function.
  The function will be given the input and a function
  that will pipe the input
  """
  @callback pipe?(any) :: boolean

  defmacro defpipes(pipes) do
    create(pipes)
  end

  def create(pipes) do
    pipes
    |> Enum.map(fn {operator, pipe} -> {operator, operator_function(pipe)} end)
    |> Lily.Operator.create(:defmacro)
  end

  defp operator_function(pipe) do
    quote do
      fn a, f ->
        pipe = unquote(pipe)

        quote do
          apply(unquote(pipe), [unquote(a), fn a -> a |> unquote(f) end])
        end
      end
    end
  end
end
