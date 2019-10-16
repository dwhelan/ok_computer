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
