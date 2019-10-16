defmodule OkComputer.Pipe.False do
  alias OkComputer.Pipe

  @behaviour Pipe

  @impl Pipe
  def bind(nil, f), do: f.(nil)
  def bind(false, f), do: f.(false)
  def bind(a, _f), do: a

  @impl Pipe
  def map(nil, f), do: f.(nil)
  def map(false, f), do: f.(false)
  def map(a, _f), do: a
end
