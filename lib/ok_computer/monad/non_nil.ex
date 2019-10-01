defmodule OkComputer.Monad.NonNil do
  alias OkComputer.Monad

  @behaviour Monad

  @impl Monad
  def return(a), do: a

  @impl Monad
  def bind(nil, _f), do: nil
  def bind(a, f), do: f.(a)

  @impl Monad
  def value_quoted(value) when not is_nil(value) do
    value
  end
end
