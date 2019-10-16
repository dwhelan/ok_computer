defmodule OkComputer.Pipe do
  @moduledoc """
  A monad that short circuits inputs it cannot handle.

  `OkComputer.Monad.bind/2` and `OkComputer.Monad.fmap/2` expect to be given a monad as the input.
  Behaviour when they are given an input they can't handle is undefined as it is out of scope for a type-based monad.

  A PipeMonad implements `bind/2` and `fmap/2` so they always return inputs they cannot handle.

  This lets you pipe functions that operate in different monadic contexts together.
  """
  @type monad :: any
  @type a :: any

  @doc """
  Calls

  A default implementation simply calls `bind/2`
  """
  @callback fmap(monad, f :: (a -> a)) :: monad

  @doc """

  """
  @callback bind(monad, f :: (a -> monad)) :: monad

  defmacro __using__(_) do
    quote do
      alias OkComputer.Pipe

      @behaviour Pipe

      @impl Pipe
      def fmap(a, f), do: bind(a, f)

      defoverridable fmap: 2
    end
  end
end
