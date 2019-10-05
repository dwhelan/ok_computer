defmodule OkComputer.Switch.ValueNil do
  alias OkComputer.Monad.{Value, Nil}
  alias OkComputer.Operation.{Case}

  import OkComputer.Switch

  build [Case], ~>: Value, ~>>: Nil

  # pipes
  # build [Case], [Value, Nil] # operators

  # build [Value, Nil] # error!
end
