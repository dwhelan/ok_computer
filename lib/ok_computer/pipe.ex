defprotocol OkComputer.PipeProtocol do

end

defmodule OkComputer.Pipe do
  @moduledoc """
  A monad that short circuits inputs it cannot handle.

  `OkComputer.Monad.bind/2` and `OkComputer.Monad.map/2` expect to be given a monad as input.
  Behaviour when they are given an input they can't handle is undefined as it is out of scope for a type-based monad.

  A Pipe implements `bind/2` and `map/2` so they always return inputs they cannot handle.
  In effect, they broaden the scope of these functions to handle any input.
  This lets you pipe through functions that operate in different monadic contexts together.
  """
  @type t :: any

  @doc """
  Calls
  """
  @callback map(t, f :: (any -> any)) :: t

  @doc """

  """
  @callback bind(t, f :: (any -> t)) :: t
end
