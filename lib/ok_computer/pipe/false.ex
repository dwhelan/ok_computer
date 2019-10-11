defmodule OkComputer.Pipe.False do
  alias OkComputer.Pipe
  use Pipe

  @impl Pipe
  def bind(nil, f), do: f.(nil)
  def bind(false, f), do: f.(false)
  def bind(anything_else, _f), do: anything_else
end
