defmodule OkComputer.Monads.Truthy do
  def return(a), do: a

  def bind(nil, f), do: nil
  def bind(false, f), do: false
  def bind(a, f), do: f.(a)
end
