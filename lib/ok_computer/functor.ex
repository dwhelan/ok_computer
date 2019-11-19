defmodule OkComputer.Functor do
  @moduledoc """
  Describes functor behaviour.
  """

  @doc "fmap"
  @callback fmap(any, f :: (any -> any)) :: any
end
