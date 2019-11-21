defmodule OkComputer.Monad.Error do
  alias OkComputer.Monad
  import Monad

  monad do
    @impl Monad
    def return(a), do: {:error, a}

    @impl Monad
    def bind({:error, a}, f), do: f.(a)
    def bind({:ok, a}, f), do: {:ok, a}

    def pipe({{:error, a}, f}, g), do: g.({:error, a}, f)
    def pipe({a, f}, g), do: a
  end
end
