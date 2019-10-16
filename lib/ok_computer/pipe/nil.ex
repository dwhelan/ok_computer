defmodule OkComputer.Pipe.Nil do
  alias OkComputer.Pipe

  @behaviour Pipe

  @impl Pipe
  def bind(nil, f), do: f.(nil)
  def bind(a, _f), do: a

  @impl Pipe
  def fmap(nil, f), do: f.(nil)
  def fmap(a, _f), do: a
end
