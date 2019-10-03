defmodule OkComputer.Monad.Truthy do
  alias OkComputer.Monad

  @behaviour Monad

  @impl Monad
  def return(a), do: a

  @impl Monad
  def bind(nil, _f), do: nil
  def bind(false, _f), do: false
  def bind(a, f), do: f.(a)

  @impl Monad
  def wrap(a), do: a
end
