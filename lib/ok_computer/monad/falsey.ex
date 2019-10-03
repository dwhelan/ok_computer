defmodule OkComputer.Monad.Falsey do
  alias OkComputer.Monad

  @behaviour Monad

  @impl Monad
  def return(a), do: a

  @impl Monad
  def bind(nil, f), do: f.(nil)
  def bind(false, f), do: f.(false)
  def bind(a, _f), do: a

  @impl Monad
  def wrap(a), do: a
end
