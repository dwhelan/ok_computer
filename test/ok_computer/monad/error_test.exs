defmodule OkComputer.Monad.ErrorTest do
  use ExUnit.Case
  alias OkComputer.Monad.Error
  import OkComputer.Pipe
  import Monad.Laws
  import Error

  defpipes(
    ~>: &Error.bind/2,
    ~>>: &Error.map/2
  )

  def stringify(a), do: {:error, to_string(a)}

  test "return" do
    assert return(:a) == {:error, :a}
  end

  test "bind" do
    f = fn :a -> {:error, "a"} end
    assert bind({:error, :a}, f) == {:error, "a"}
  end

  test "map" do
    f = fn :a -> "a" end
    assert map({:error, :a}, f) == {:error, "a"}
  end

  test "pipe bind" do
    assert {:error, :a} ~> stringify() == {:error, "a"}
    assert :a ~> stringify() == :a
  end

  test "pipe map" do
    assert {:error, :a} ~>> to_string() == {:error, "a"}
    assert :a ~>> to_string() == :a
  end

  test_monad(Error, {:error, :a})
end
