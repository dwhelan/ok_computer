defmodule OkComputer.Pipe.Value do
  alias OkComputer.Pipe

  @behaviour Pipe

  @impl Pipe
  def bind(nil, _f), do: nil
  def bind(a, f), do: f.(a)

  @impl Pipe
  def fmap(nil, _f), do: nil
  def fmap(a, f), do: f.(a)
end
