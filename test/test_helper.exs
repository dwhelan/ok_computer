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
          assert @a |> @monad.bind(&@monad.return/1) == @a
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
