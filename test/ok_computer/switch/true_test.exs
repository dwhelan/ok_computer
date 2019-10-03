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

  test "case_ok" do
    assert(
      case_ok(true) do
        value -> to_string(value)
      end == "true"
    )
  end

  test "case_error" do
    assert(
      case_error(false) do
        value -> to_string(value)
      end == "false"
    )
  end
end
