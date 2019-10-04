defmodule OkComputer.Switch.Ok do
  alias OkComputer.Monad.{Ok, Error}
  alias OkComputer.Operation.{Case}

  import OkComputer.Switch

  switch2([Case], ok: {Ok, :~>}, error: {Error, :~>>})
end
