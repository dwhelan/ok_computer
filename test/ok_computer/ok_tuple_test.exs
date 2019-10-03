defmodule OkComputer.OkTupleTest do
  use ExUnit.Case
  import OkComputer.OkTuple

  doctest OkComputer.OkTuple

  @tag :skip
  test "ok pipe" do
    assert {:ok, :a} ~> to_string() == {:ok, "a"}
    assert :anything_else ~> to_string() == :anything_else
  end

  @tag :skip
  test "error pipe" do
    assert {:ok, :a} ~>> to_string() == {:ok, :a}
    assert :anything_else ~>> to_string() == "anything_else"
  end

  @tag :skip
  test "case_ok" do
    stringify = fn value ->
      case_ok value do
        value -> to_string(value)
      end
    end

    assert stringify.({:ok, :a}) == {:ok, "a"}
    assert stringify.(:anything_else) == :anything_else
  end

  @tag :skip
  test "case_error" do
    stringify = fn value ->
      case_error value do
        value -> to_string(value)
      end
    end

    assert stringify.({:ok, :a}) == {:ok, "a"}
    assert stringify.(:anything_else) == :anything_else
  end
end
