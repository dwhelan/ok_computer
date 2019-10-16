defmodule OkComputer.Monad.Result do
  alias OkComputer.{Monad, Pipe}
  use Monad

  @impl Monad
  def return(value), do: {:ok, value}

  @impl Monad
  def bind({:ok, value}, f), do: f.(value)
  def bind(a, _f), do: a
end
