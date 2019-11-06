defmodule OkComputer.Operator.TildeRightTest do
  use ExUnit.Case
  import OkComputer.NewOperator

  operator :~>, &(to_string(&1) <> to_string(&2))

  test "~>/2" do
    assert :a ~> :b == "ab"
  end
end

defmodule OkComputer.Operator.TildeRightMacroTest do
  use ExUnit.Case
  import OkComputer.NewOperator

  operator_macro(:~>, fn left, right ->
    quote do
      to_string(unquote(left)) <> to_string(unquote(right))
    end
  end)

  test "~>/2" do
    assert :a ~> :b == "ab"
  end
end