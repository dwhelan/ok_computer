defmodule MonadTest do

  defmodule A do
    @behaviour Monad

    def atoms(), do: [:a]

    def return({:a, v}), do: {:a, "A #{inspect v}"}
    def return(v),       do: {:a, "A #{inspect v}"}

    defmacro foo x do
      IO.inspect x
    end
  end

  defmodule B do
    @behaviour Monad

    def atoms(), do: [:b]

    def return({:b, v}), do: {:b, "B #{inspect v}"}
    def return(v),       do: {:b, "B #{inspect v}"}
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

    describe "return/1 should" do
      test "map tuples to module via atoms" do
        assert return({:a, :v}) == {:a, "A :v" }
      end

      test "map bare values to the module" do
        assert return(:_) == {:a, "A :_"}
      end
    end
  end

  defmodule UseMultiple do
    use ExUnit.Case

    use Monad, [A, B]

    describe "return/1 should" do
      test "map tuples to modules via atoms" do
        assert return({:a, :v}) == {:a, "A :v" }
        assert return({:b, :v}) == {:b, "B :v" }
      end

      test "map bare values to the first module" do
        assert return(:_) == {:a, "A :_"}
      end
    end
  end
end

