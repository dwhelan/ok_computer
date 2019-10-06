defmodule OkComputer.Monad.True do
  alias OkComputer.Monad

  use Monad

  @impl Monad
  def bind(nil, _f), do: nil
  def bind(false, _f), do: false
  def bind(a, f), do: f.(a)
end
