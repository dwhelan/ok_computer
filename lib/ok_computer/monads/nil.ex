defmodule OkComputer.Monads.Nil do
  def bind(nil, f), do: f.(nil)
  def bind(a, f), do: a
end
