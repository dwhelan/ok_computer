defmodule OkComputer.Falsey do
  def bind(nil, f), do: f.(nil)
  def bind(false, f), do: f.(false)
  def bind(a, f), do: a
end
