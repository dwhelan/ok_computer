defmodule OkComputer.Pipe do
  @moduledoc """
  Support for creating pipe operators.

  A pipe consists of an operator and a pipe function.

  A pipe function has an arity of two.
  The function will be given the input and a function
  that will pipe the input
  """
  defmacro defpipes(pipes) do
    create(pipes)
  end

  def create(pipes) do
    pipes
    |> Enum.map(fn {operator, pipe_function} -> {operator, operator_function(pipe_function)} end)
    |> Lily.Operator.create(:defmacro)
  end

  defp operator_function(pipe_function) do
    quote do
      fn a, f ->
        pipe_function = unquote(pipe_function)

        quote do
          apply(unquote(pipe_function), [unquote(a), fn a -> a |> unquote(f) end])
        end
      end
    end
  end
end