defmodule OkComputer.Monad.ResultTest do
  alias OkComputer.Monad.Result

  use ExUnit.Case
  import Monad.Laws
  import Result

  test "return" do
    assert return(:value) == {:ok, :value}
  end

  test "bind" do
    f = fn value -> {:ok, "#{value}"} end

    assert bind({:ok, :value}, f) == {:ok, "value"}
    assert bind(:anything_else, f) == :anything_else
  end

  test "fmap" do
    f = fn value -> "#{value}" end

    assert fmap({:ok, :value}, f) == {:ok, "value"}
    assert fmap(:anything_else, f) == :anything_else
  end

  test_monad(Result, {:ok, :value})
  test_monad(Result, :anything_else)
end
