defmodule OkComputer.TruthyTest do
  use ExUnit.Case
  import OkComputer.Truthy
  import OkComputer.Pipes
  import OkComputer.Case

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
    stringify_oks = fn value ->
      case_ok value do
        value -> to_string(value)
      end
    end

    assert stringify_oks.(nil) == nil
    assert stringify_oks.(false) == false
    assert stringify_oks.(:anything_else) == "anything_else"
  end
end
