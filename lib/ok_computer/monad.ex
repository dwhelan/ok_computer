defmodule OkComputer.Monad do
  @moduledoc """
  Monadic pipes.
  """
  @type monad(_any) :: any
  @type a :: any
  @type b :: any

  @doc "return"
  @callback return(a) :: monad(a)

  @doc "bind"
  @callback bind(monad(a), f :: (a -> monad(b))) :: monad(b)

  defmacro __using__(_) do
    quote do
      alias OkComputer.{Monad, Functor, Applicative}

      @behaviour Monad
      @behaviour Functor
      @behaviour Applicative

      @impl Functor
      def map(a, f), do: bind(a, &(f.(&1) |> return()))

      @impl Applicative
      def apply(a, f), do: bind(f, &map(a, &1))
    end
  end
end
