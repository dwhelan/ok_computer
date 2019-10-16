defmodule OkComputer.Monad.Error do
  alias OkComputer.{Monad, Pipe}
  use Monad

  @impl Monad
  def return(reason), do: {:error, reason}

  @impl Monad
  def bind({:error, reason}, f), do: f.(reason)

  @impl Pipe
  def bind({:error, reason}, f), do: f.(reason)
  def bind(a, _f), do: a

  @impl Pipe
  def fmap({:error, reason}, f), do: {:error, f.(reason)}
  def fmap(a, _f), do: a
end
