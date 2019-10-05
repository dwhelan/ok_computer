defmodule OkComputer.Switch.NonNilTest do
  alias OkComputer.Switch.NonNil

  use ExUnit.Case
  import NonNil

  doctest NonNil

  test "ok pipe" do
    assert :value ~> to_string() == "value"
  end

  test "nil pipe" do
    assert nil ~>> to_string() == ""
  end

  test "case_ok" do
    assert(
      case_ok :value do
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
