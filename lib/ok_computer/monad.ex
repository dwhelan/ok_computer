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
      alias OkComputer.{Monad, Functor, Applicative}
      import Monad

      @behaviour Monad
      @behaviour Functor
      @behaviour Applicative

      @impl Functor
      def fmap(a, f), do: bind(a, &(f.(&1) |> return()))

      @impl Applicative
      def apply(a, f), do: bind(f, &fmap(a, &1))

      unquote(block)
    end
  end
end
