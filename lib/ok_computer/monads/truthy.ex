defmodule OkComputer.Monads.Truthy do
  alias OkComputer.Monad
  @behaviour Monad

  @impl Monad
  def return(a), do: a

  @impl Monad
  def bind(nil, f), do: nil
  def bind(false, f), do: false
  def bind(a, f), do: f.(a)
end
