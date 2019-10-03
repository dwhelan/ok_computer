defmodule OkComputer.Monad.OkTuple do
  alias OkComputer.Monad

  @behaviour Monad

  @impl Monad
  def return(a), do: {:ok, a}

  @impl Monad
  def bind({:ok, a}, f), do: f.(a)
  def bind(a, _f), do: a

  @impl Monad
  def wrap({:ok, value}), do: {:ok, value}
  def wrap({:error, reason}), do: {:error, reason}
  def wrap(nil), do: {:error, nil}
  def wrap(other), do: {:ok, other}
end

defmodule OkComputer.Monad.ErrorTuple do
  alias OkComputer.Monad

  @behaviour Monad

  @impl Monad
  def return(a), do: {:error, a}

  @impl Monad
  def bind({:error, a}, f), do: f.(a)
  def bind(a, _f), do: a
end
