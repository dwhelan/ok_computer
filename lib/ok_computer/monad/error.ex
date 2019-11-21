defmodule OkComputer.Monad.Error do
  alias OkComputer.Monad
  import Monad

  monad do
    @impl Monad
    def return(a), do: {:error, a}

    @impl Monad
    def bind({:error, a}, f), do: f.(a)
    def bind({:ok, a}, f), do: {:ok, a}

    def pipe({:error, a}, f), do: bind(a, f)
    def pipe(a, _f), do: a
  end
end
