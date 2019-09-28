defmodule OkComputer.NonNil do
  def bind(nil, f), do: nil
  def bind(a, f), do: f.(a)
end
