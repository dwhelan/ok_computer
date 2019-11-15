defmodule OkComputer.Monad.Ok do
  alias OkComputer.Monad
  import Monad

  monad do
    @impl Monad
    def return(a), do: {:ok, a}

    @impl Monad
    def bind({:ok, a}, f), do: f.(a)
    def bind(a, _f), do: a
  end
end
