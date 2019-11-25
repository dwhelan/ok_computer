defmodule OkComputer.Monad.OkTest do
  use ExUnit.Case
  alias OkComputer.Monad.Ok
  import Lily.Pipe
  import Ok
  import Monad.Laws

  test "return/1" do
    assert return(:a) == {:ok, :a}
  end

  test "bind/2" do
    f = fn :a -> {:ok, "a"} end
    assert bind({:ok, :a}, f) == {:ok, "a"}
    assert bind(:a, f) == :a
  end

  test "fmap/2" do
    f = fn :a -> "a" end
    assert fmap({:ok, :a}, f) == {:ok, "a"}
    assert fmap(:a, f) == :a
  end

  describe "pipe" do
    pipe ~>: &Ok.bind/2

    def to_ok_string(:a), do: {:ok, "a"}

    test "bind/2" do
      assert {:ok, :a} ~> to_ok_string() == {:ok, "a"}
      assert :a ~> to_ok_string() == :a
    end

    pipe ~>>: &Ok.fmap/2

    test "fmap/2" do
      assert {:ok, :a} ~>> to_string() == {:ok, "a"}
      assert :a ~>> to_string() == :a
    end
  end

  test_monad(Ok, {:ok, :a})
end
