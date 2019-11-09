defmodule OkComputer.BinaryOperatorTest do
  use ExUnit.Case
  import OkComputer.Operator

  operator :+, fn left, right -> to_string(left) <> to_string(right) end

  test "+/2" do
    assert :a + :b == "ab"
  end
end
