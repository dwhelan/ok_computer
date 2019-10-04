defmodule OkComputer.Switch.Ok do
  alias OkComputer.Monad.{Ok, Error}
  alias OkComputer.Operation.{Case}

  import OkComputer.Switch

  build [Case], ok: {Ok, :~>}, error: {Error, :~>>}
end
