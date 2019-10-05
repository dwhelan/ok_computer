defmodule OkComputer.Switch.OkError do
  alias OkComputer.Monad.{Ok, Error}
  alias OkComputer.Operation.{Case}

  import OkComputer.Switch

  build2 [Case], ~>: Ok, ~>>: Error
end
