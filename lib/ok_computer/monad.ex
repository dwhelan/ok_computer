defmodule OkComputer.Monad do
  @moduledoc """
  Describes monadic behaviour.
  """
  @type t :: any

  @doc "return"
  @callback return(any) :: t

  @doc "bind"
  @callback bind(t, (any -> t)) :: t

  @impl Monad
  @callback wrap(any) :: any

  def name(monad) do
      monad |> Module.split() |> List.last |> String.downcase
  end

end

