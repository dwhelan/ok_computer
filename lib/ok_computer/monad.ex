defmodule OkComputer.Monad do
  @moduledoc """
  Monadic pipes.
  """
  @type t :: any

  @doc "return"
  @callback return(any) :: t

  @doc "bind"
  @callback bind(t, f :: (any -> t)) :: t

  defmacro monad(do: block) do
    quote do
      alias OkComputer.{Monad, Functor, Applicative, Pipe}
      import Monad

      @behaviour Monad
      @behaviour Functor
      @behaviour Applicative
      @behaviour Pipe

      @impl Functor
      def map(a, f), do: bind(a, &(f.(&1) |> return()))

      @impl Applicative
      def apply(a, f), do: bind(f, &map(a, &1))

      unquote(block)
    end
  end
end
