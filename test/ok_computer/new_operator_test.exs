defmodule OkComputer.NewOperatorTest do
  defmodule Plus do
    use ExUnit.Case
    import OkComputer.NewOperator

    operator_macro(:+, fn left, right ->
      quote do
         to_string(unquote(left)) <> to_string(unquote(right))
      end
    end)

    test "~>" do
      assert :a + :b == "ab"
    end
  end

  defmodule At do
    use ExUnit.Case
    import OkComputer.NewOperator

    operator_macro(:@, fn input ->
      quote do
        to_string(unquote(input))
      end
    end)

    test "@" do
      assert @ :a == "a"
    end
  end

  defmodule TildeRight do
    use ExUnit.Case
    import OkComputer.NewOperator

    operator_macro(:~>, fn left, right ->
      quote do
        unquote(left) |> unquote(right)
      end
    end)

    test "~>" do
      assert :a ~> to_string() == "a"
    end
  end

  defmodule TildeRightRight do
    use ExUnit.Case
    import OkComputer.NewOperator

    operator_macro(:~>>, fn left, right ->
      quote do
        unquote(left) |> unquote(right)
      end
    end)

    test "~>>" do
      assert :a ~>> to_string() == "a"
    end
  end
end
