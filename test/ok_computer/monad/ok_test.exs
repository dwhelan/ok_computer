defmodule OkComputer.Monad.OkTest do
  alias OkComputer.Monad.Ok

  use ExUnit.Case
  import Monad.Laws
  import Ok

  test "return" do
    assert return(:value) == {:ok, :value}
  end

  test "bind" do
    f = fn value -> {:ok, to_string(value)} end

    assert bind({:ok, :value}, f) == {:ok, "value"}
    assert bind({:error, :value}, f) == {:error, :value}
    assert bind(nil, f) == nil
  end

  test "fmap" do
    f = fn value -> to_string(value) end

    assert fmap({:ok, :value}, f) == {:ok, "value"}
    assert fmap({:error, :value}, f) == {:error, :value}
    assert fmap(nil, f) == nil
  end

  test_monad(Ok, {:ok, :value})
  test_monad(Ok, :value)
end
