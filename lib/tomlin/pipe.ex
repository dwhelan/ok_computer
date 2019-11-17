defmodule OkComputer.Pipe do
  @moduledoc """
  Support for creating pipes.

  A pipe consists of an operator and a pipe function.

  A pipe function has an arity of two.
  The function will be given the input and a function
  that will pipe the input
  """
  import Lily.Operator

  defmacro defpipes(pipes) do
    create(pipes, __CALLER__)
  end

  def create(pipes, env) do
    create(:defmacro, operator_functions(pipes, env), env)
  end

  defp operator_functions(pipes, env) do
    Enum.map(
      pipes,
      fn {operator, pipe_function} ->
        case arity(pipe_function, env) do
          2 -> {operator, operator_function(pipe_function)}
        end
      end
    )
  end

  defp operator_function(pipe_function) do
    quote do
      fn a, f ->
        pipe_function = unquote(pipe_function)

        quote do
          unquote(pipe_function).(unquote(a), fn a -> a |> unquote(f) end)
        end
      end
    end
  end
end
