defmodule OkComputer.Truthy do
  import OkComputer.Monad

  monad()

  def ok?(nil), do: false
  def ok?(false), do: false
  def ok?(_), do: true
end
