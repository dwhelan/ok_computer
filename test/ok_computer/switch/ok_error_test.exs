defmodule OkComputer.Switch.OkErrorTest do
  alias OkComputer.Switch.OkError

  use ExUnit.Case
  import OkError

  doctest OkError

  test "~> Ok.fmap" do
    assert {:ok, :a} ~> to_string() == {:ok, "a"}
    assert :anything_else ~> to_string() == :anything_else
  end

  test "~>> Ok.bind" do
    assert {:ok, %{a: 1}} ~>> Map.fetch(:a) == {:ok, 1}
    assert :anything_else ~> to_string() == :anything_else
  end

#  @tag :skip
#  test "error pipe" do
#    assert {:ok, :a} ~>> to_string() == {:ok, :a}
#    assert :anything_else ~>> to_string() == "anything_else"
#  end

#  @tag :skip
#  test "case_ok" do
#    stringify = fn value ->
#      case_ok value do
#        value -> to_string(value)
#      end
#    end
#
#    assert stringify.({:ok, :a}) == {:ok, "a"}
#    assert stringify.(:anything_else) == :anything_else
#  end
#
#  @tag :skip
#  test "case_error" do
#    stringify = fn value ->
#      case_error value do
#        value -> to_string(value)
#      end
#    end
#
#    assert stringify.({:ok, :a}) == {:ok, "a"}
#    assert stringify.(:anything_else) == :anything_else
#  end
end
