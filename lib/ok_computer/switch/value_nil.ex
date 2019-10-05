defmodule OkComputer.Switch.ValueNil do
  alias OkComputer.Monad.{Value, Nil}
  alias OkComputer.Operation.{Case}

  import OkComputer.Switch

  build2 [Case], ~>: Value, ~>>: Nil

  # pipes
#  build2(~>: Value, ~>>: Nil)
  # build [Case], ~>: Value, ~>>: Nil # pipes and operations
  # build [Case], [Value, Nil] # operators

  # build [Value, Nil] # error!
end
