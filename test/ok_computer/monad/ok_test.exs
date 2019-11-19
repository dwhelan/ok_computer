defmodule OkComputer.Monad.OkTest do
  use ExUnit.Case
  alias OkComputer.Monad.Ok
  import OkComputer.Pipe
  import Monad.Laws
  import Ok

  defpipes(
    ~>: &Ok.bind/2,
    ~>>: &Ok.fmap/2
  )

  def stringify(a), do: {:ok, to_string(a)}

  test "return" do
    assert return(:a) == {:ok, :a}
  end

  test "bind" do
    f = fn :a -> {:ok, "a"} end
    assert bind({:ok, :a}, f) == {:ok, "a"}
  end

  test "fmap" do
    f = fn :a -> "a" end
    assert fmap({:ok, :a}, f) == {:ok, "a"}
  end

  test "pipe bind" do
    assert {:ok, :a} ~> stringify() == {:ok, "a"}
    assert :a ~> stringify() == :a
  end

  test "pipe fmap" do
    assert {:ok, :a} ~>> to_string() == {:ok, "a"}
    assert :a ~>> to_string() == :a
  end

  test_monad(Ok, {:ok, :a})
end
