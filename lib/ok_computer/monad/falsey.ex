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
  def value_quoted(value) when value in [nil, false] do
    value
  end
end
