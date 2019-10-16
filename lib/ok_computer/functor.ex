defmodule OkComputer.Functor do
  @moduledoc """
  Describes functor behaviour.
  """
  @type functor:: any

  @doc "map"
  @callback map(functor, (a :: any -> any)) :: functor
end
