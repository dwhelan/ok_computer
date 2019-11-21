defmodule OkComputer.Monad.Ok do
  alias OkComputer.Monad
  import Monad

  monad do
    @impl Monad
    def return(a), do: {:ok, a}

    @impl Monad
    def bind({:ok, a}, f), do: f.(a)
    def bind({:error, a}, _f), do: {:error, a}

    def pipe({{:ok, a}, f}, g), do: g.({:ok, a}, f)
    def pipe({a, f}, f), do: a
  end

  defmacro pipe_function(match) do
    quote do
      def pipe({a, f}, g) do
        case a do
          unquote(match) -> g.(a, f)
          a -> a
        end
      end

      def pipe({{:ok, a}, f}, g), do: g.({:ok, a}, f)
      def pipe({a, f}, f), do: a
    end
  end
end
