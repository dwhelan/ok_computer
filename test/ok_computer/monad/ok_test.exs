defmodule OkComputer.Monad.OkTest do
  use ExUnit.Case
  alias OkComputer.Monad.Ok
  import OkComputer.Pipe
  import Monad.Laws
  import Ok

  pipe :~>, Ok, :bind
  pipe :~>>, Ok, :map

  def stringify(a), do: {:ok, to_string(a)}

  test "return" do
    assert return(:value) == {:ok, :value}
  end

  test "bind" do
    f = fn :value -> {:ok, "value"} end

    assert bind({:ok, :value}, f) == {:ok, "value"}
  end

  test "map" do
    f = fn :value -> "value" end

    assert map({:ok, :value}, f) == {:ok, "value"}
  end

  test "pipe?" do
    assert pipe?({:ok, :value})
    refute pipe?(:a)
  end

  test "pipe bind" do
    assert {:ok, :a} ~> stringify() == {:ok, "a"}
    assert :a ~> stringify() == :a
  end

  test "pipe map" do
    assert {:ok, :a} ~>> to_string() == {:ok, "a"}
    assert :a ~>> to_string() == :a
  end

  test_monad(Ok, {:ok, :value})
end
