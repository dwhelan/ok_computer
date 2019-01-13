defmodule MonadTest do

  defmodule A do
    @behaviour Monad

    def atoms(), do: [:a]

    def new({:a, v}), do: {:a, "A #{inspect v}"}
    def new(v),       do: {:a, "A #{inspect v}"}

    defmacro foo x do
      IO.inspect x
    end
  end

  defmodule B do
    @behaviour Monad

    def atoms(), do: [:b]

    def new({:b, v}), do: {:b, "B #{inspect v}"}
    def new(v),       do: {:b, "B #{inspect v}"}
  end

  defmodule UseErrors do
    use ExUnit.Case

    test "raise if no options provided" do
      TestHelper.assert_code_error "use Monad"
    end
  end

  defmodule UseSingle do
    use ExUnit.Case

    use Monad, A

    describe "new/1 should" do
      test "map tuples to module via atoms" do
        assert new({:a, :v}) == {:a, "A :v" }
      end

      test "map bare values to the module" do
        assert new(:_) == {:a, "A :_"}
      end
    end
  end

  defmodule UseMultiple do
    use ExUnit.Case

    use Monad, [A, B]

    describe "new/1 should" do
      test "map tuples to modules via atoms" do
        assert new({:a, :v}) == {:a, "A :v" }
        assert new({:b, :v}) == {:b, "B :v" }
      end

      test "map bare values to the first module" do
        assert new(:_) == {:a, "A :_"}
      end
    end
  end
end

