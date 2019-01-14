ExUnit.start()

defmodule Monad.Laws do
  defmacro __using__ _ do
    quote do
      import Monad.Laws

      test "left identity" do
        f = fn a -> return "f(#{a})" end
        a = "a"
        assert return(a) |> bind(f) == f.(a)
      end

      test "right identity" do
        m = return "a"
        assert m |> return == m
      end

      test "associativity" do
        f = fn a -> return "f(#{a})" end
        g = fn a -> return "g(#{a})" end
        m = return "a"

        assert m |> bind(f) |> bind(g) == m |> bind(fn a -> f.(a) |> bind(g) end)
      end
    end
  end
end
