defmodule OkComputer.Functor do
  @moduledoc """
  Describes functor behaviour.
  """
  @type t :: term

  @doc "fmap"
  @callback fmap(t, (term -> term)) :: t
end
