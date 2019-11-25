defmodule OkComputer.Monad.Error do
  alias OkComputer.Monad
  import Monad

  monad do
    @impl Monad
    def return(a), do: {:error, a}

    @impl Monad
    def bind({:error, a}, f), do: f.(a)
    def bind(a, _f), do: a
  end
end
