defmodule OkComputer.Monad.Ok do
  alias OkComputer.Monad
  import Monad

  monad do
    @impl Monad
    def return(a), do: {:ok, a}

    @impl Monad
    def bind({:ok, a}, f), do: f.(a)
    def bind({:error, a}, _f), do: {:error, a}

    def pipe({:ok, a}, f, pipe_fun), do: pipe_fun.({:ok, a}, f)
    def pipe(a, _f, _pipe_fun), do: a
  end
end
