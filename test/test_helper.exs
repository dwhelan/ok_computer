ExUnit.start()

defmodule OkComputer.Test do
  import ExUnit.Assertions

  def assert_operator_error_raise(string) do
    assert_raise(OkComputer.OperatorError, fn -> Code.eval_string(string) end)
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
          assert @a |> @monad.map(fn a -> a end) == @a
        end

        test "functor composition" do
          f = fn a -> "f(#{inspect(a)})" end
          g = fn a -> "g(#{inspect(a)})" end

          assert @monad.map(@a, fn a -> a |> g.() |> f.() end) ==
                   @monad.map(@a, g) |> @monad.map(f)
        end
      end
    end
  end
end
