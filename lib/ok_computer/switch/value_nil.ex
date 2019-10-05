defmodule OkComputer.Switch.ValueNil do
  alias OkComputer.Monad.{Value, Nil}
  alias OkComputer.Operation.{Case}

  import OkComputer.Switch

  build [Case], value: {:~>, Value}, nil: {:~>>, Nil}

  # build [{Value, :~>}, {Nil, :~>>}] # just pipes
  # build [{Value, :~>}, {Nil, :~>>}] # just pipes
  # build [{Value, :~>}, {Nil, :~>>}], [Case] # pipes and operations
  # build [Value, Nil], [Case] # just operators
  # build [Value, Nil] # error!
end
