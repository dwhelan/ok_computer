defmodule OkComputer.Switch.TrueTest do
  alias OkComputer.Switch.True

  use ExUnit.Case
  import True

  doctest True

  test "ok pipe" do
    assert(true ~> to_string() == "true")
  end

  test "error pipe" do
    assert(false ~>> to_string() == "false")
  end

  test "case_true" do
    assert(
      case_true(true) do
        value -> "#{value}"
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
