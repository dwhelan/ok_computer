defmodule OkComputer.Pipe.Value do
  alias OkComputer.Pipe

  @behaviour Pipe

  @impl Pipe
  def bind(nil, _f), do: nil
  def bind(a, f), do: f.(a)

  @impl Pipe
  def map(nil, _f), do: nil
  def map(a, f), do: f.(a)
end
