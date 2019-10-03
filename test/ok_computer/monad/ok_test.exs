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

    assert bind({:error, :value}, f) == {:error, :value}
    assert bind(nil, f) == nil
    assert bind({:ok, :value}, f) == {:ok, "value"}
  end

  test "wrap" do
    assert wrap({:ok, :value}) == {:ok, :value}
    assert wrap({:error, :reason}) == {:error, :reason}
    assert wrap(nil) == {:error, nil}
    assert wrap(:value) == {:ok, :value}
  end

  test_monad(Ok, :value)
end
