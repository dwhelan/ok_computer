defmodule Lily.Monad.ErrorTest do
  use ExUnit.Case
  alias Lily.Monad.Error
  import Lily.Pipe
  import Error
  import Monad.Laws

  test "return" do
    assert return(:a) == {:error, :a}
  end

  test "bind" do
    f = fn :a -> {:error, "a"} end
    assert bind({:error, :a}, f) == {:error, "a"}
    assert bind(:a, f) == :a
  end

  test "fmap" do
    f = fn :a -> "a" end
    assert fmap({:error, :a}, f) == {:error, "a"}
    assert fmap(:a, f) == :a
  end

  describe "pipe" do
    pipe ~>: &Error.bind/2

    def to_error_string(:a), do: {:error, "a"}

    test "bind/2" do
      assert {:error, :a} ~> to_error_string() == {:error, "a"}
      assert :a ~> to_error_string() == :a
    end

    pipe ~>>: &Error.fmap/2

    test "fmap/2" do
      assert {:error, :a} ~>> to_string() == {:error, "a"}
      assert :a ~>> to_string() == :a
    end
  end

  test_monad(Error, {:error, :a})
end
