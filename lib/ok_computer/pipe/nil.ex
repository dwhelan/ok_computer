defmodule OkComputer.Pipe.Nil do
  alias OkComputer.Pipe
  use Pipe

  @impl Pipe
  def bind(nil, f), do: f.(nil)
  def bind(anything_else, _f), do: anything_else
end
