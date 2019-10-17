defmodule OkComputer.Functor do
  @moduledoc """
  Describes functor behaviour.
  """
  @type t :: any

  @doc "map"
  @callback map(t, f :: (any -> any)) :: t
end
