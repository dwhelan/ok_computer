defmodule OkComputer.OkTupleTest do
  use ExUnit.Case
  import OkComputer.OkTuple

  doctest OkComputer.OkTuple

  @tag :skip
  test "ok pipe" do
    assert({:ok, :a} ~> to_string() == {:ok, "anything_else"})
#    assert(nil ~> to_string() == nil)
#    assert(false ~> to_string() == false)
  end

  test "error pipe" do
    assert(nil ~>> to_string() == "")
    assert(false ~>> to_string() == "false")
    assert(:anything_else ~>> to_string() == :anything_else)
  end

#  test "case_ok" do
#    stringify = fn value ->
#      case_ok value do
#        value -> to_string(value)
#      end
#    end
#
#    assert stringify.(nil) == nil
#    assert stringify.(false) == false
#    assert stringify.(:anything_else) == "anything_else"
#  end
#
#  test "case_error" do
#    stringify = fn value ->
#      case_error value do
#        value -> to_string(value)
#      end
#    end
#
#    assert stringify.(nil) == ""
#    assert stringify.(false) == "false"
#    assert stringify.(:anything_else) == :anything_else
#  end
end
