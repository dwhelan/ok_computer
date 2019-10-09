defmodule OkComputer.Pipe.Value do
  alias OkComputer.Pipe
  use Pipe

  @impl Pipe
  def bind(nil, _f), do: nil
  def bind(a, f), do: f.(a)
end
