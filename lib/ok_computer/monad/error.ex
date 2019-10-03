defmodule OkComputer.Monad.Error do
  alias OkComputer.Monad

  @behaviour Monad

  @impl Monad
  def return(value), do: {:error, value}

  @impl Monad
  def bind({:error, value}, f), do: f.(value)
  def bind(value, _f), do: value

  @impl Monad
  def wrap({:ok, value}), do: {:ok, value}
  def wrap({:error, reason}), do: {:error, reason}
  def wrap(nil), do: {:error, nil}
  def wrap(other), do: {:ok, other}
end