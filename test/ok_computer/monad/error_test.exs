defmodule OkComputer.Monad.ErrorTest do
  use ExUnit.Case
  alias OkComputer.Monad.Error
  import Error
  import Monad.Laws

  test "return" do
    assert return(:a) == {:error, :a}
  end

  test "bind" do
    f = fn :a -> {:error, "a"} end
    assert bind({:error, :a}, f) == {:error, "a"}
    assert bind({:ok, :a}, f) == {:ok, :a}
    assert bind(:a, f) == :a
  end

  test "fmap" do
    f = fn :a -> "a" end
    assert fmap({:error, :a}, f) == {:error, "a"}
    assert fmap({:ok, :a}, f) == {:ok, :a}
    assert fmap(:a, f) == :a
  end

  test_monad(Error, {:error, :a})
end
