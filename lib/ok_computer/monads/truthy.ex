defmodule OkComputer.Monads.Truthy do
  def bind(nil, f), do: nil
  def bind(false, f), do: false
  def bind(a, f), do: f.(a)
end
