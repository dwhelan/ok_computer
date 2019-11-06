defmodule OkComputer.Monad.ResultTest do
  use ExUnit.Case
  alias OkComputer.Monad.Result
  import OkComputer.NewPipe
  import Monad.Laws
  import Result

  pipe :~>, Result, :bind
  pipe :~>>, Result, :map

  def stringify(a), do: {:ok, to_string(a)}

  test "return" do
    assert return(:value) == {:ok, :value}
  end

  test "bind" do
    f = fn :value -> {:ok, "value"} end

    assert bind({:ok, :value}, f) == {:ok, "value"}
    assert bind(:anything_else, f) == :anything_else
  end

  test "map" do
    f = fn :value -> "value" end

    assert map({:ok, :value}, f) == {:ok, "value"}
    assert map(:anything_else, f) == :anything_else
  end

  test "pipe bind" do
    assert {:ok, :a} ~> stringify() == {:ok, "a"}
    assert :a ~> stringify() == :a
  end

  test "pipe map" do
    assert {:ok, :a} ~>> to_string() == {:ok, "a"}
    assert :a ~>> to_string() == :a
  end

  test_monad(Result, {:ok, :value})
end
