defmodule OkComputer.Switch.TrueFalseTest do
  alias OkComputer.Switch.TrueFalse

  use ExUnit.Case
  import TrueFalse

  doctest TrueFalse

  test "true pipe" do
    assert(true ~> to_string() == "true")
  end

  test "false pipe" do
    assert(false ~>> to_string() == "false")
  end

  test "case_true" do
    assert(
      case_true(true) do
        value -> to_string(value)
      end == "true"
    )
  end

  test "case_false" do
    assert(
      case_false(false) do
        value -> to_string(value)
      end == "false"
    )
  end
end
