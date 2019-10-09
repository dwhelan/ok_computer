defmodule OkComputer.Pipe.False do
  alias OkComputer.Monad

  use Monad

  @impl Monad
  def bind(nil, f), do: f.(nil)
  def bind(false, f), do: f.(false)
  def bind(a, _f), do: a
end
