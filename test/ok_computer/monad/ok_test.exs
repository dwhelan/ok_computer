defmodule OkComputer.Monad.OkTest do
  use ExUnit.Case
  alias OkComputer.Monad.Ok
  import Monad.Laws
  import Ok

  test "return/1" do
    assert return(:a) == {:ok, :a}
  end

  test "bind/2" do
    f = fn :a -> {:ok, "a"} end
    assert bind({:ok, :a}, f) == {:ok, "a"}
    assert bind({:error, :a}, f) == {:error, :a}
    assert bind(:a, f) == :a
  end

  test "fmap/2" do
    f = fn :a -> "a" end
    assert fmap({:ok, :a}, f) == {:ok, "a"}
    assert fmap({:error, :a}, f) == {:error, :a}
    assert fmap(:a, f) == :a
  end

  describe "pipe" do
  test "bind/2" do
    f = fn :a -> {:ok, "a"} end
    assert bind({:ok, :a}, f) == {:ok, "a"}
    assert bind({:error, :a}, f) == {:error, :a}
    assert bind(:a, f) == :a
  end

  end
  test_monad(Ok, {:ok, :a})
end
