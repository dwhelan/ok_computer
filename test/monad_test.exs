defmodule MonadTest do
  use ExUnit.Case

  defmodule A do
    @behaviour Monad

    def atoms(), do: [:a]

    def new({:a, v}), do: {:a, "A #{inspect v}"}
    def new(v),       do: {:a, "A #{inspect v}"}
  end

  defmodule B do
    @behaviour Monad

    def atoms(), do: [:b]

    def new({:b, v}), do: {:b, "B #{inspect v}"}
    def new(v),       do: {:b, "B #{inspect v}"}
  end

  use Monad, [A, B]

  describe "use should" do
    test "raise if no options provided" do
      assert_code_raise "use Monad"
    end
  end

  describe "should create 'new' methods that" do
    test "map tuples to modules via atoms" do
      assert new({:a, :v}) == {:a, "A :v" }
      assert new({:b, :v}) == {:b, "B :v" }
    end

    test "map bare values to the first module" do
      assert new(:_) == {:a, "A :_"}
    end
  end

  def assert_code_raise code do
    ExUnit.Assertions.assert_raise ArgumentError, fn -> Code.eval_string(code) end
  end


end

