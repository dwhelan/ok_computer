defmodule OkComputer.Monads.NonNil do
  def return(a), do: a

  def bind(nil, f), do: nil
  def bind(a, f), do: f.(a)
end
