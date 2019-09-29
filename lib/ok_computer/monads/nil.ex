defmodule OkComputer.Monads.Nil do
  def return(a), do: a

  def bind(nil, f), do: f.(nil)
  def bind(a, f), do: a
end
