defmodule OkComputer.Switch.NonNil do
  alias OkComputer.Monad.{NonNil, Nil}
  alias OkComputer.Operation.{Case}

  import OkComputer.Switch

  build [Case], ok: {:~>, NonNil}, nil: {:~>>, Nil}
end
