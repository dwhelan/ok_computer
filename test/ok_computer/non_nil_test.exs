defmodule OkComputer.NonNilTest do
  use ExUnit.Case
  import OkComputer.NonNil

  doctest OkComputer.NonNil

  test "ok pipe" do
    assert(nil ~> to_string() == nil)
    assert(:anything_else ~> to_string() == "anything_else")
  end

  test "error pipe" do
    assert(nil ~>> to_string() == "")
    assert(:anything_else ~>> to_string() == :anything_else)
  end

  test "case_ok" do
    stringify = fn value ->
      case_ok value do
        value -> to_string(value)
      end
    end

    assert stringify.(nil) == nil
    assert stringify.(:anything_else) == "anything_else"
  end

  test "case_error" do
    stringify = fn value ->
      case_error value do
        value -> to_string(value)
      end
    end

    assert stringify.(nil) == ""
    assert stringify.(:anything_else) == :anything_else
  end
end
