defmodule OkComputer.Functor do
  @moduledoc """
  Describes functor behaviour.
  """
  @type functor(_any) :: any
  @type f(a) :: (a -> a)
  @type a :: any

  @doc "map"
  @callback map(functor(a), f(a)) :: functor(a)
end
