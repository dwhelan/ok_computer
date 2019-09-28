defmodule OkComputer.NonNil do
  import OkComputer.Monad

  monad()

  def ok?(nil), do: false
  def ok?(_), do: true
end
