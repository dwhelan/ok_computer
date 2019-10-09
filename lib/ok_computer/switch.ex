defmodule OkComputer.Switch do
  @moduledoc """
  Pipes and macros for handling ok and error values.

  A switch provides pipe operators and macros for handling
  both ok and error values.
  """
  alias OkComputer.Monad

  @callback wrap(any) :: Monad.t()
  @callback unwrap(Monad.t()) :: any

  @doc """
  Builds a switch with operators and pipes.
  """
  defmacro build(operations, pipe_monads) do
    [
      build_pipes(pipe_monads),
      build_operations(operations, pipe_monads)
    ]
  end

  defmacro build(pipe_monads) do
    build_pipes(pipe_monads)
  end

  defp build_pipes(pipe_monads) do
    for pipe_monad <- pipe_monads do
      build_pipe(pipe_monad)
    end
  end

  defp build_pipe({pipe, monad}) do
    quote do
      alias OkComputer.Pipe
      require Pipe
      Pipe.pipes(unquote(monad), bind: unquote(pipe))
    end
  end

  defp build_pipe(monad) do
  end

  defp build_operations(operations, pipe_monads) do
    for operation <- operations, pipe_monad <- pipe_monads do
      build_operation(operation, pipe_monad)
    end
  end

  defp build_operation(operation, {_pipe, monad}) do
    build_operation(operation, monad)
  end

  defp build_operation(operation, monad) do
    quote do
      require unquote(operation)
      unquote(operation).build(unquote(monad))
    end
  end

  defmacro __using__(_) do
    quote do
      alias OkComputer.Switch
      use OkComputer.Monad
      import Switch

      @behaviour Switch

      @impl Switch
      def wrap(a), do: a

      @impl Switch
      def unwrap(a), do: a

      defoverridable wrap: 1, unwrap: 1
    end
  end
end
