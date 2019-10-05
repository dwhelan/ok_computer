defmodule OkComputer.Switch do
  @moduledoc """
  Pipes and macros for handling ok and error values.

  A switch provides pipe operators and macros for handling
  both ok and error values.
  """

  @doc """
  Builds a switch with operators and pipes.
  """
  defmacro build2(pipes) do
  end

  defmacro build(operations, monads) do
    [
      for operation <- operations, {name, monad} <- monads do
        build_operation(operation, {name, monad})
      end,
      for monad <- monads do
        build_pipe(monad)
      end
    ]
  end

  defp build_pipe({_, {pipe, monad}}) do
    quote do
      alias OkComputer.Operation.Pipe
      require Pipe
      Pipe.build(unquote(pipe), unquote(monad))
    end
  end

  defp build_operation(operation, {name, {_pipe, monad}}) do
    quote do
      require unquote(operation)
      unquote(operation).build(unquote(name), unquote(monad))
    end
  end
end
