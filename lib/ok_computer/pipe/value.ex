defmodule OkComputer.Pipe.Value do
  alias OkComputer.Pipe
  use Pipe

  @impl Pipe
  def bind(nil, _f), do: nil
  def bind(anything_else, f), do: f.(anything_else)
end
