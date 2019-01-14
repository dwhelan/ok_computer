defmodule MonadTest do

  defmodule A do
    @behaviour Monad

    def return({:a, v}), do: {:a, v}
    def return(v),       do: {:a, v}

    def bind({:a, v}, f), do: f.(v)
    def bind(m, _f),      do: m
  end

  defmodule B do
    @behaviour Monad

    def return({:b, v}), do: {:b, v}
    def return(v),       do: {:b, v}

    def bind({:b, v}, f), do: f.(v)
    def bind(m, _f),      do: m
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

    test "should delegate return/1 to module" do
      assert return(:v) == {:a, :v}
    end

    test "should delegate bind/2 to module" do
      assert bind({:a, 'v'}, fn x -> return "f(#{x})" end) == {:a, "f(v)"}
    end
  end

  defmodule UseMultiple do
    use ExUnit.Case

    use Monad, [A, B]

    test "should delegate return/1 to first module" do
      assert return(:v) == {:a, :v}
    end

    test "should delegate bind/2 to first module" do
      assert bind({:a, 'v'}, fn x -> return "f(#{x})" end) == {:a, "f(v)"}
    end
  end
end

