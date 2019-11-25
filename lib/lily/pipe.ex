defmodule Lily.Pipe do
  @moduledoc """
  Support for creating pipes.

  A pipe consists of an operator and a pipe function of arity 2.

  The pipe function will be given an input and a function to call.
  """
  import Lily.{Operator, Function}
  alias Lily.Error

  @doc """
  Creates pipes.

  Creates pipes for each pipe in `pipes`.

  The key is the operator and the value is the function that should be called.

  """
  defmacro pipe(pipes) do
    pipe(pipes, __CALLER__)
  end

  def pipe(pipes, env) do
    operator_macro(operator_functions(pipes, env), env)
  end

  defp operator_functions(pipes, env) do
    Enum.map(
      pipes,
      fn {operator, pipe_function} ->
        case Code.Identifier.binary_op(operator) do
          {:left, _} ->
            :ok

          _ ->
            raise Error,
                  "expected a binary operator with left to right associativity but got #{operator}."
        end

        cond do
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
