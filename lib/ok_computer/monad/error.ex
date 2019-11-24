defmodule OkComputer.Monad.Error do
  alias OkComputer.Monad
  import Monad

  monad do
    @impl Monad
    def return(a), do: {:error, a}

    @impl Monad
    def bind({:error, a}, f), do: f.(a)
    def bind({:ok, a}, _f), do: {:ok, a}

    def pipe({:error, a}, f, pipe_fun), do: pipe_fun.({:error, a}, f)
    def pipe(a, _f, _g), do: a
  end
end
