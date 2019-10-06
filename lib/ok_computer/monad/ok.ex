defmodule OkComputer.Monad.Ok do
  alias OkComputer.Monad

  @behaviour Monad

  @impl Monad
  def return(value), do: {:ok, value}

  @impl Monad
  def bind({:ok, value}, f), do: f.(value)
  def bind(value, _f), do: value
end
