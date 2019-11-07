defmodule OkComputer.Monad.Result do
  alias OkComputer.{Monad, Pipe}
  import Monad

  monad do
    @impl Monad
    def return(value), do: {:ok, value}

    @impl Monad
    def bind({:ok, value}, f), do: f.(value)
    def bind(a, _f), do: a

    @impl Pipe
    def pipe?({:ok, _}), do: true
    def pipe?(_), do: false
  end
end
