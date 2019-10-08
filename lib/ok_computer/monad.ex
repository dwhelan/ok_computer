defmodule OkComputer.Monad do
  @moduledoc """
  Describes monadic behaviour.
  """
  @type t :: any

  @doc "return"
  @callback return(any) :: t

  @doc "bind"
  @callback bind(t, (any -> t)) :: t

  @doc "fmap"
  @callback fmap(t, (any -> any)) :: t

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
