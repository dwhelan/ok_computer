defmodule OkComputer.NewOperatorTest do
  defmodule At do
    use ExUnit.Case
    import OkComputer.NewOperator

    operator_macro(:@, fn input ->
      quote do
        unquote(input) |> to_string()
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
