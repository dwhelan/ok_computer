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
      alias OkComputer.{Pipe, Monad, Functor}

      @behaviour Pipe
      @behaviour Monad
      @behaviour Functor

      @impl Functor
      def fmap(a, f), do: bind(a, fn a -> f.(a) |> return() end)
    end
  end
end
