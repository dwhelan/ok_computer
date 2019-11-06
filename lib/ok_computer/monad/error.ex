defmodule OkComputer.Monad.Error do
  alias OkComputer.{Monad, NewPipe}
  import Monad
  use NewPipe

  monad do
    @impl Monad
    def return(a), do: {:error, a}

    @impl Monad
    def bind({:error, a}, f), do: f.(a)
    def bind(a, _f), do: a
  end

  @impl NewPipe
  def pipe?({:error, _}), do: true
  def pipe?(_), do: false
end
