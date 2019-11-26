defmodule OkComputer.Applicative do
  @moduledoc """
  Describes applicative behaviour.
  """
  @type t :: term

  @doc "apply"
  @callback apply(t, t) :: t
end
