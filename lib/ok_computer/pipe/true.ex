defmodule OkComputer.Pipe.True do
  alias OkComputer.Pipe
  use Pipe

  @impl Pipe
  def pipe_bind(nil, _f), do: nil
  def pipe_bind(false, _f), do: false
  def pipe_bind(anything_else, f), do: f.(anything_else)
end
