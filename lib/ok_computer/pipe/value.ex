defmodule OkComputer.Pipe.Value do
  alias OkComputer.Monad

  use Monad

  @impl Monad
  def bind(nil, _f), do: nil
  def bind(a, f), do: f.(a)
end
