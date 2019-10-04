defmodule OkComputer.Switch do
  @moduledoc """
  Pipes and macros for handling ok and error values.

  A switch provides pipe operators and macros for handling
  both ok and error values.
  """

  @doc """
  Builds a switch with operators and pipes.
  """
  defmacro build(operations, monads) do
    [
      build_operations(operations, monads),
      build_pipes(monads)
    ]
  end

  defp build_pipes(monads) do
    for monad <- monads, into: [] do
      build_pipe(monad)
    end
  end

  defp build_pipe({_, {monad, pipe}}) do
    quote do
      alias OkComputer.Operation.Pipe
      import Pipe
      Pipe.build(unquote(pipe), unquote(monad))
    end
  end

  defp build_operations(operations, monads) do
    for operation <- operations, {name, monad} <- monads, into: [] do
      build_operation(operation, {name, monad})
    end
  end

  defp build_operation(operation, {name, {monad, _pipe}}) do
    quote do
      require unquote(operation)
      unquote(operation).build(unquote(name), unquote(monad))
    end
  end
end
