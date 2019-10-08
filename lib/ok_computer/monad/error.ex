defmodule OkComputer.Monad.Error do
  alias OkComputer.Monad

  use Monad

  @impl Monad
  def return(value), do: {:error, value}

  @impl Monad
  def bind({:error, value}, f), do: f.(value)
  def bind(value, _f), do: value
end
