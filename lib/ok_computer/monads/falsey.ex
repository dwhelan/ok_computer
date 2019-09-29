defmodule OkComputer.Monads.Falsey do
  alias OkComputer.Monad
  @behaviour Monad

  @impl Monad
  def return(a), do: a

  @impl Monad
  def bind(nil, f), do: f.(nil)
  def bind(false, f), do: f.(false)
  def bind(a, f), do: a
end
