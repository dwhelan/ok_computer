defmodule OkComputer.Monad.OkTest do
  use ExUnit.Case
  alias OkComputer.Monad.Ok
  import OkComputer.Pipe
  import Monad.Laws
  import Ok

  defpipes(
    ~>: &Ok.bind/2,
    ~>>: &Ok.map/2
  )

  def stringify(value), do: {:ok, to_string(value)}

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
    refute pipe?(:value)
  end

  test "pipe bind" do
    assert {:ok, :value} ~> stringify() == {:ok, "value"}
    assert :value ~> stringify() == :value
  end

  test "pipe map" do
    assert {:ok, :value} ~>> to_string() == {:ok, "value"}
    assert :value ~>> to_string() == :value
  end

  test_monad(Ok, {:ok, :value})
end
