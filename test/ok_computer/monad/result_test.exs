defmodule OkComputer.Monad.ResultTest do
  use ExUnit.Case
  alias OkComputer.Monad.Result
  import Monad.Laws
  import Result

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

  test_monad(Result, {:ok, :value})
end
