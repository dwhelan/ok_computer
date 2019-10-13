defmodule OkComputer.Monad.Error do
  alias OkComputer.{Monad, Pipe}
  use Monad

  @impl Monad
  def return(reason), do: {:error, reason}

  @impl Monad
  def bind({:error, reason}, f), do: f.(reason)

  @impl Pipe
  def pipe_bind(anything_else, _f), do: anything_else
  def pipe_fmap(anything_else, _f), do: anything_else
end
