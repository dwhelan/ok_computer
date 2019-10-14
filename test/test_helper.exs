ExUnit.start()

defmodule OkComputerTest do
  def assert_code_raise(error, code) do
    ExUnit.Assertions.assert_raise(error, fn -> Code.eval_string(code) end)
  end
end

defmodule EncodeTest do
  defmacro __using__(_) do
    quote do
      use ExUnit.Case

      import DataTypes
      import OkError
      import Codec.Encode
    end
  end
end

defmodule DecodeTest do
  defmacro __using__(_) do
    quote do
      use ExUnit.Case

      import DataTypes
      import OkError
      import Codec.Decode
    end
  end
end

defmodule Monad.Laws do
  defmacro test_monad(monad, m) do
    quote do
      @monad unquote(monad)
      @m unquote(m)

      describe "#{inspect(@m)}" do
        test "monad left identity" do
          f = fn a -> @monad.return("f(#{inspect(a)})") end
          assert @m |> @monad.return() |> @monad.bind(f) == f.(@m)
        end

        test "monad right identity" do
          assert @m |> @monad.bind(&@monad.return/1) == @m
        end

        test "monad associativity" do
          f = fn a -> @monad.return("f(#{inspect(a)})") end
          g = fn a -> @monad.return("g(#{inspect(a)})") end

          assert @m |> @monad.bind(f) |> @monad.bind(g) ==
                   @m |> @monad.bind(fn a -> f.(a) |> @monad.bind(g) end)
        end

        test "functor identity" do
          assert @m |> @monad.fmap(fn a -> a end) == @m
        end

        test "functor composition" do
          f = fn a -> "f(#{inspect(a)})" end
          g = fn a -> "g(#{inspect(a)})" end

          assert @monad.fmap(@m, fn a -> a |> g.() |> f.() end) ==
                   @monad.fmap(@m, g) |> @monad.fmap(f)
        end
      end
    end
  end
end
