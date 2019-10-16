defmodule OkComputer.Pipe.True do
  alias OkComputer.Pipe

  @behaviour Pipe

  @impl Pipe
  def bind(nil, _f), do: nil
  def bind(false, _f), do: false
  def bind(a, f), do: f.(a)

  @impl Pipe
  def map(nil, _f), do: nil
  def map(false, _f), do: false
  def map(a, f), do: f.(a)
end
