defmodule OkComputer.Monad.Result do
  alias OkComputer.Monad

  use Monad

  @impl Monad
  def return(value), do: {:ok, value}

  @impl Monad
  def bind({:ok, value}, f), do: f.(value)
  def bind(anything_else, _f), do: anything_else
end
