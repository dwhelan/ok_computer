defmodule OkComputer.OperatorTest do
  use ExUnit.Case
  import OkComputer.Operator

  operator :+, fn input -> to_string(input) end

  test "+/1" do
    assert +:a == "a"
  end

  operator :+, fn left, right -> to_string(left) <> to_string(right) end

  test "+/2" do
    assert :a + :b == "ab"
  end
end
