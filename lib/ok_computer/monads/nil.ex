defmodule OkComputer.Monads.Nil do
  alias OkComputer.Monad
  @behaviour Monad

  @impl Monad
  def return(a), do: a

  @impl Monad
  def bind(nil, f), do: f.(nil)
  def bind(a, f), do: a
end
