defmodule OkComputer.Switch.ValueNil do
  alias OkComputer.Pipe.{Value, Nil}
  alias OkComputer.Operation.{Case}

  use OkComputer.Switch

  build [Case], ~>: Value, ~>>: Nil

  @impl Monad
  def bind(nil, f), do: Nil.bind(nil, f)
  def bind(a, f), do: Value.bind(a, f)
end
