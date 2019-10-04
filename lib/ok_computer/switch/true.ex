defmodule OkComputer.Switch.True do
  alias OkComputer.Monad.{True, False}
  alias OkComputer.Operation.{Case}

  import OkComputer.Switch

  switch2([Case], ok: {True, :~>}, error: {False, :~>>})
end
