defmodule OkComputer.Monad.ErrorTest do
  use ExUnit.Case
  alias OkComputer.Monad.Error
  import OkComputer.NewPipe
  import Monad.Laws
  import Error

  pipe :~>, Error, :bind
  pipe :~>>, Error, :map

  def stringify(a), do: {:error, to_string(a)}

  test "return" do
    assert return(:reason) == {:error, :reason}
  end

  test "bind" do
    f = fn :reason -> {:error, "reason"} end

    assert bind({:error, :reason}, f) == {:error, "reason"}
    assert bind(:anything_else, f) == :anything_else
  end

  test "map" do
    f = fn :reason -> "reason" end

    assert map({:error, :reason}, f) == {:error, "reason"}
    assert map(:anything_else, f) == :anything_else
  end

  test "pipe bind" do
    assert {:error, :a} ~> stringify() == {:error, "a"}
    assert :a ~> stringify() == :a
  end

  test "pipe map" do
    assert {:error, :a} ~>> to_string() == {:error, "a"}
    assert :a ~>> to_string() == :a
  end

  test_monad(Error, {:error, :reason})
end
