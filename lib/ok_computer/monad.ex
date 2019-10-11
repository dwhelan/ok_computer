defmodule OkComputer.Monad do
  @moduledoc """
  Describes monadic behaviour.
  """
  @type t :: term

  @doc "return"
  @callback return(term) :: t

  @doc "bind"
  @callback bind(t, (term -> t)) :: t

  @doc "fmap"
  @callback fmap(t, (term -> term)) :: t

  def name(monad) do
    monad
    |> Module.split()
    |> List.last()
    |> String.downcase()
  end

  defmacro __using__(_) do
    quote do
      alias OkComputer.Monad
      import Monad

      @behaviour Monad

      @impl Monad
      def return(a), do: a

      @impl Monad
      def fmap(a, f), do: bind(a, fn a -> f.(a) |> return() end)

      defoverridable return: 1
    end
  end
end
