defmodule OkComputer.Pipe.True do
  alias OkComputer.Pipe
  use Pipe

  @impl Pipe
  def bind(nil, _f), do: nil
  def bind(false, _f), do: false
  def bind(anything_else, f), do: f.(anything_else)
end
