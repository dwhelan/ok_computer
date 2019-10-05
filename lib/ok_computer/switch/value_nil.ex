defmodule OkComputer.Switch.ValueNil do
  alias OkComputer.Monad.{Value, Nil}
  alias OkComputer.Operation.{Case}

  import OkComputer.Switch

  build([Case], ~>: Value, ~>>: Nil)

  # pipes
  #  build(~>: Value, ~>>: Nil)
  # build [Case], ~>: Value, ~>>: Nil # pipes and operations
  # build [Case], [Value, Nil] # operators

  # build [Value, Nil] # error!
end
