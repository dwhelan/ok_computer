defmodule OkComputer.Pipe.Nil do
  alias OkComputer.Pipe
  use Pipe

  @impl Pipe
  def pipe_bind(nil, f), do: f.(nil)
  def pipe_bind(anything_else, _f), do: anything_else
end
