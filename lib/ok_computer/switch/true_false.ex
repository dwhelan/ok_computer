defmodule OkComputer.Switch.TrueFalse do
  alias OkComputer.Monad.{True, False}
  alias OkComputer.Operation.{Case}

  import OkComputer.Switch

  build [Case], ~>: True, ~>>: False

  def return(a), do: a

  def bind(nil, f), do: False.bind(nil, f)
  def bind(false, f), do: False.bind(false, f)
  def bind(a, f), do: True.bind(a, f)
end
