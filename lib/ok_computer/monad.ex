defmodule OkComputer.Monad do
  @moduledoc """
  Describes monadic behaviour.
  """
  @type t :: any

  @doc "return"
  @callback return(any) :: t

  @doc "bind"
  @callback bind(t, (any -> t)) :: t

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

      defoverridable return: 1
    end
  end
end
