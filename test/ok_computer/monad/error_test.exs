defmodule OkComputer.Monad.ErrorTest do
  use ExUnit.Case
  alias OkComputer.Monad.Error
  import Lily.Pipe
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

  describe "pipe" do
    defpipes ~>: &Error.bind/2

    def to_ok_string(:a), do: {:error, "a"}

    test "bind/2" do
      assert {:error, :a} ~> to_ok_string() == {:error, "a"}
      assert {:ok, :a} ~> to_ok_string() == {:ok, :a}
      assert :a ~> to_ok_string() == :a
    end

    defpipes ~>>: &Error.fmap/2

    test "fmap/2" do
      assert {:error, :a} ~>> to_string() == {:error, "a"}
      assert {:ok, :a} ~>> to_string() == {:ok, :a}
      assert :a ~>> to_string() == :a
    end
  end

  test_monad(Error, {:error, :a})
end
