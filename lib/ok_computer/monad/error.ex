defmodule OkComputer.Monad.Error do
  alias OkComputer.{Monad, Pipe}
  use Monad

  @impl Monad
  def return(reason), do: {:error, reason}

  @impl Monad
  def bind({:error, reason}, f), do: f.(reason)

  @impl Pipe
  def pipe_bind({:error, reason}, f), do: f.(reason)
  def pipe_bind(a, _f), do: a

  @impl Pipe
  def pipe_fmap({:error, reason}, f), do: {:error, f.(reason)}
  def pipe_fmap(a, _f), do: a
end
