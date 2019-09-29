defmodule OkComputer.Monads.NonNil do
  def bind(nil, f), do: nil
  def bind(a, f), do: f.(a)

  def return(x), do: x
end
