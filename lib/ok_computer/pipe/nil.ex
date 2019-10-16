defmodule OkComputer.Pipe.Nil do
  alias OkComputer.Pipe

  @behaviour Pipe

  @impl Pipe
  def bind(nil, f), do: f.(nil)
  def bind(a, _f), do: a

  @impl Pipe
  def map(nil, f), do: f.(nil)
  def map(a, _f), do: a
end
