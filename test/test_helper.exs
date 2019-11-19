ExUnit.start()

defmodule Lily.Test do
  def to_string(a, b) do
    "#{a}#{b}"
  end

  def quoted_to_string(a) do
    quote(do: "#{unquote(a)}")
  end

  def quoted_to_string(a, b) do
    quote(do: "#{unquote(a)}#{unquote(b)}")
  end
end

defmodule Monad.Laws do
  defmacro test_monad(monad, a) do
    quote do
      @monad unquote(monad)
      @a unquote(a)

      describe "#{inspect(@a)}" do
        test "monad left identity" do
          f = fn a -> @monad.return("f(#{inspect(a)})") end
          assert @a |> @monad.return() |> @monad.bind(f) == f.(@a)
        end

        test "monad right identity" do
          m = @monad.return(@a)
          assert m |> @monad.bind(&@monad.return/1) == m
        end

        test "monad associativity" do
          f = fn a -> @monad.return("f(#{inspect(a)})") end
          g = fn a -> @monad.return("g(#{inspect(a)})") end

          assert @a |> @monad.bind(f) |> @monad.bind(g) ==
                   @a |> @monad.bind(fn a -> f.(a) |> @monad.bind(g) end)
        end

        test "functor identity" do
          assert @a |> @monad.fmap(fn a -> a end) == @a
        end

        test "functor composition" do
          f = fn a -> "f(#{inspect(a)})" end
          g = fn a -> "g(#{inspect(a)})" end

          assert @monad.fmap(@a, fn a -> a |> g.() |> f.() end) ==
                   @monad.fmap(@a, g) |> @monad.fmap(f)
        end
      end
    end
  end
end
