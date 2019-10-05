defmodule OkComputer.Switch.ValueNilTest do
  alias OkComputer.Switch.ValueNil

  use ExUnit.Case
  import ValueNil

  doctest ValueNil

  test "value pipe" do
    assert :value ~> to_string() == "value"
  end

  test "nil pipe" do
    assert nil ~>> to_string() == ""
  end

  test "case_value" do
    assert(
      case_value :value do
        value -> to_string(value)
      end == "value"
    )
  end

  test "case_nil" do
    assert(
      case_nil nil do
        value -> to_string(value)
      end == ""
    )
  end
end
