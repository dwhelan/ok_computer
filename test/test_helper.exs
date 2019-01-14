ExUnit.start()

defmodule Monad.Laws do
  defmacro __using__ _ do
    # Copied from Hex monad library: need to validate
    quote do
      test "left identity" do
        f = fn x -> x * x end
        a = 2
        assert bind(return(a), f) == f.(a)
      end

      test "right identity" do
        m = return 42
        assert bind(m, &return/1) == m
      end

      test "associativity" do
        f = fn (x) -> x * x end
        g = fn (x) -> x - 1 end
        m = return 2
        assert bind(return(bind(m, f)), g) == bind(m, &bind(return(f.(&1)), g))
      end
    end
  end
end
