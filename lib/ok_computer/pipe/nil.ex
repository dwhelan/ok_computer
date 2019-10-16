defmodule OkComputer.Pipe.Nil do
  alias OkComputer.Pipe
  use Pipe

  @impl Pipe
  def bind(nil, f), do: f.(nil)
  def bind(a, _f), do: a
end
