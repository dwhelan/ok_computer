defmodule OkComputer.Switch.ValueNil do
  alias OkComputer.Monad.{Value, Nil}
  alias OkComputer.Operation.{Case}

  import OkComputer.Switch

  build [Case], ~>: Value, ~>>: Nil

  def return(a), do: a

  def bind(nil, f), do: Nil.bind(nil, f)
  def bind(a, f), do: Value.bind(a, f)
end
