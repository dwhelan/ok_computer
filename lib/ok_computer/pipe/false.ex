defmodule OkComputer.Pipe.False do
  alias OkComputer.Pipe
  use Pipe

  @impl Pipe
  def pipe_bind(nil, f), do: f.(nil)
  def pipe_bind(false, f), do: f.(false)
  def pipe_bind(anything_else, _f), do: anything_else
end
