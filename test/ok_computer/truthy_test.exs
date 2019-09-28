defmodule OkComputer.TruthyTest do
  use ExUnit.Case
  use OkComputer.Truthy

  doctest OkComputer.Truthy

  test "ok pipe" do
    assert(nil ~> to_string() == nil)
    assert(false ~> to_string() == false)
    assert(:anything_else ~> to_string() == "anything_else")
  end

  test "error pipe" do
    assert(nil ~>> to_string() == "")
    assert(false ~>> to_string() == "false")
    assert(:anything_else ~>> to_string() == :anything_else)
  end

  test "case_ok" do
    stringify = fn value ->
      case_ok value do
        value -> to_string(value)
      end
    end

    assert stringify.(nil) == nil
    assert stringify.(false) == false
    assert stringify.(:anything_else) == "anything_else"
  end
end
