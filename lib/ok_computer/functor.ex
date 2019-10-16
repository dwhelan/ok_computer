defmodule OkComputer.Functor do
  @moduledoc """
  Describes functor behaviour.
  """
  @type functor(_any) :: any
  @type a :: any
  @type b :: any

  @doc "map"
  @callback map(functor(a), f :: (a -> b)) :: functor(b)
end
