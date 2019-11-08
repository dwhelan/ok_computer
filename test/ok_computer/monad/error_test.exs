defmodule OkComputer.Monad.ErrorTest do
  use ExUnit.Case
  alias OkComputer.Monad.Error
  import OkComputer.Pipe
  import Monad.Laws
  import Error

  pipe :~>, Error, :bind
  pipe :~>>, Error, :map

  def stringify(reason), do: {:error, to_string(reason)}

  test "return" do
    assert return(:reason) == {:error, :reason}
  end

  test "bind" do
    f = fn :reason -> {:error, "reason"} end
    assert bind({:error, :reason}, f) == {:error, "reason"}
  end

  test "map" do
    f = fn :reason -> "reason" end
    assert map({:error, :reason}, f) == {:error, "reason"}
  end

  test "pipe?" do
    assert pipe?({:error, :reason})
    refute pipe?(:reason)
  end

  test "pipe bind" do
    assert {:error, :reason} ~> stringify() == {:error, "reason"}
    assert :reason ~> stringify() == :reason
  end

  test "pipe map" do
    assert {:error, :reason} ~>> to_string() == {:error, "reason"}
    assert :reason ~>> to_string() == :reason
  end

  test_monad(Error, {:error, :reason})
end
