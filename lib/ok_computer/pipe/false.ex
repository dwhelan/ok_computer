defmodule OkComputer.Pipe.False do
  alias OkComputer.Pipe

  @behaviour Pipe

  @impl Pipe
  def bind(nil, f), do: f.(nil)
  def bind(false, f), do: f.(false)
  def bind(a, _f), do: a

  @impl Pipe
  def fmap(nil, f), do: f.(nil)
  def fmap(false, f), do: f.(false)
  def fmap(a, _f), do: a
end
