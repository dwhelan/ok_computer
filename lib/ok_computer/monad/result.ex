defmodule OkComputer.Monad.Result do
  alias OkComputer.{Monad, Pipe}
  use Monad

  @impl Monad
  def return(value), do: {:ok, value}

  @impl Monad
  def bind({:ok, value}, f), do: f.(value)

  @impl Pipe
  def pipe_bind({:ok, value}, f), do: f.(value)
  def pipe_bind(a, _f), do: a

  @impl Pipe
  def pipe_fmap({:ok, value}, f), do: {:ok, f.(value)}
  def pipe_fmap(a, _f), do: a
end
