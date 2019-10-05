defmodule OkComputer.Switch.True do
  alias OkComputer.Monad.{True, False}
  alias OkComputer.Operation.{Case}

  import OkComputer.Switch

  build [Case], true: {:~>, True}, false: {:~>>, False}
end
