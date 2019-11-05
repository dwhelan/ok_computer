defmodule OkComputer.Monad.Error do
  alias OkComputer.Monad
  import Monad

  monad do
    @impl Monad
    def return(reason), do: {:error, reason}

    @impl Monad
    def bind({:error, reason}, f), do: f.(reason)
    def bind(a, _f), do: a
  end
end
