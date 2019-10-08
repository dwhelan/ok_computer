defmodule OkComputer.Monad.Nil do
  alias OkComputer.Monad

  use Monad

  @impl Monad
  def bind(nil, f), do: f.(nil)
  def bind(a, _f), do: a
end
