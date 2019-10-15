defmodule OkComputer.Monad do
  @moduledoc """
  Monadic pipes.
  """
  @type t :: term

  @doc "return"
  @callback return(term) :: t

  @doc "bind"
  @callback bind(t, (term -> t)) :: t

  defmacro __using__(_) do
    quote do
      alias OkComputer.{Pipe, Monad, Functor, Applicative}

      @behaviour Pipe
      @behaviour Monad
      @behaviour Functor
      @behaviour Applicative

      @impl Functor
      def fmap(a, f), do: bind(a, fn a -> f.(a) |> return() end)

      @impl Applicative
      def apply(a, f), do: bind(f, &fmap(a, &1))
    end
  end
end
