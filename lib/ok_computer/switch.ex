defmodule OkComputer.Switch do
  @moduledoc """
  Pipes and macros for handling ok and error values.

  A switch provides pipe operators and macros for handling
  both ok and error values.
  """

  @doc """
  Builds a switch with operators and pipes.
  """
  defmacro build(operations, pipe_monads) do
    [
      build_operations(operations, pipe_monads),
      build_pipes(pipe_monads)
    ]
  end

  defmacro build(pipe_monads) do
    build_pipes(pipe_monads)
  end

  defp build_pipes(pipe_monads) do
    for pipe_monad <- pipe_monads, is_tuple(pipe_monad) do
      {pipe, monad} = pipe_monad
      quote do
        alias OkComputer.Pipe
        require Pipe
        Pipe.build(unquote(pipe), unquote(monad))
      end
    end
  end

  defp build_operations(operations, pipe_monads) do
    for operation <- operations, {_pipe, monad} <- pipe_monads do
      quote do
        require unquote(operation)
        unquote(operation).build(unquote(monad))
      end
    end
  end
end
