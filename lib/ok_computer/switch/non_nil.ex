defmodule OkComputer.Switch.NonNil do
  alias OkComputer.Monad.{NonNil, Nil}
  alias OkComputer.Operation.{Case}

  import OkComputer.Switch

  switch2([Case], ok: {NonNil, :~>}, error: {Nil, :~>>})
end
