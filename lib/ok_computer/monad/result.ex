defmodule OkComputer.Monad.Result do
  alias OkComputer.{Monad, Pipe}
  use Monad

  @impl Monad
  def return(value), do: {:ok, value}

  @impl Monad
  def bind({:ok, value}, f), do: f.(value)

  @impl Pipe
  def bind({:ok, value}, f), do: f.(value)
  def bind(a, _f), do: a

  @impl Pipe
  def fmap({:ok, value}, f), do: {:ok, f.(value)}
  def fmap(a, _f), do: a
end
