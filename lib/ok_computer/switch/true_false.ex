defmodule OkComputer.Switch.TrueFalse do
  alias OkComputer.Monad.{True, False}
  alias OkComputer.Operation.{Case}

  import OkComputer.Switch

  build2 [Case], ~>: True, ~>>: False
end
