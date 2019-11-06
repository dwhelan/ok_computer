defmodule OkComputer.OperatorTest do
  defmodule TildeRight do
    use ExUnit.Case
    import OkComputer.Operator

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
    import OkComputer.Operator

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
