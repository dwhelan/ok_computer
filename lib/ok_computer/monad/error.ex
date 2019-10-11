defmodule OkComputer.Monad.Error do
  alias OkComputer.Monad

  use Monad

  @impl Monad
  def return(reason), do: {:error, reason}

  @impl Monad
  def bind({:error, reason}, f), do: f.(reason)
  def bind(anything_else, _f), do: anything_else
end
