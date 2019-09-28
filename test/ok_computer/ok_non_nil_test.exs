defmodule OkComputer.NonNilTest do
  use ExUnit.Case
  use OkComputer.OkNonNil

  doctest OkComputer.OkNonNil

  test "ok pipe" do
    assert(nil ~> to_string() == nil)
    assert(:anything_else ~> to_string() == "anything_else")
  end

  test "error pipe" do
    assert(nil ~>> to_string() == "")
    assert(:anything_else ~>> to_string() == :anything_else)
  end

  test "case_ok" do
    stringify_oks = fn value ->
      case_ok value do
        value -> to_string(value)
      end
    end

    assert stringify_oks.(nil) == nil
    assert stringify_oks.(:anything_else) == "anything_else"
  end
end
