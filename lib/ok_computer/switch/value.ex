defmodule OkComputer.Switch.Value do
  alias OkComputer.Monad.{Value, Nil}
  alias OkComputer.Operation.{Case}

  import OkComputer.Switch

  build [Case], ok: {:~>, Value}, nil: {:~>>, Nil}
end
