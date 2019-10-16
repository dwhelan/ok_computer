defmodule OkComputer.Functor do
  @moduledoc """
  Describes functor behaviour.
  """
  @type t :: term

  @doc "map"
  @callback map(t, (term -> term)) :: t
end
