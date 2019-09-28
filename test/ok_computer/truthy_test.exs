defmodule OkComputer.TruthyTest do
  use ExUnit.Case
  import OkComputer.Truthy
  import OkComputer.Pipes

  doctest OkComputer.Truthy

  test "ok operator" do
    assert((nil ~> to_string()) == nil)
    assert((false ~> to_string()) == false)
    assert((:anything_else ~> to_string()) == "anything_else")
  end

  test "error operator" do
    assert((nil ~>> to_string()) == "")
    assert((false ~>> to_string()) == "false")
    assert((:anything_else ~>> to_string()) == :anything_else)
  end

  test "case_ok" do
    f = fn value ->
      case_ok value do
        1 -> "one"
        2 -> "two"
        3 -> "three"
      end
    end

    assert f.(nil) == nil

    assert f.(false) == false
    assert f.(1) == "one"
    assert f.(2) == "two"
    assert f.(3) == "three"

    x = 1
    assert f.(x) == "one"

    assert_raise CaseClauseError, fn -> f.(4) end
  end
end
