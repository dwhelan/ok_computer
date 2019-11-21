defmodule OkComputer.Monad.OkTest do
  use ExUnit.Case
  alias OkComputer.Monad.Ok
  import Monad.Laws
  import Ok

  def stringify(a), do: {:ok, to_string(a)}

  test "return" do
    assert return(:a) == {:ok, :a}
  end

  test "bind" do
    f = fn :a -> {:ok, "a"} end
    assert bind({:ok, :a}, f) == {:ok, "a"}
    assert bind({:error, :a}, f) == {:error, :a}
  end

  test "fmap" do
    f = fn :a -> "a" end
    assert fmap({:ok, :a}, f) == {:ok, "a"}
    assert fmap({:error, :a}, f) == {:error, :a}
  end

  test_monad(Ok, {:ok, :a})
end
