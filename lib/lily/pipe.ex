defmodule OkComputer.Pipe do
  @moduledoc """
  Support for creating pipes.

  A pipe consists of an operator and a pipe function of arity 2.

  The pipe function will be given an input and a function that pipes its input
  to the .
  """
  import Lily.{Operator, Function}
  alias Lily.Error

  @doc """
  Creates pipes.

  Creates pipes for pipe in `pipes`.

  The key is the operator name and the value is the function that the pipe operator should call.
  The function should return an expression which results from the pipe.

  ## Examples

      iex>

  """
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
        cond do
          Macro.operator?(operator, 2) != true ->
            raise Error,
                  "expected an operator with arity 2 but got #{operator}."

          arity(pipe_function, env) != 2 ->
            raise Error,
                  "expected a pipe function with arity 2 but it has arity #{
                    arity(pipe_function, env)
                  }."

          true ->
            {operator, operator_function(pipe_function)}
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
