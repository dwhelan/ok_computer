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
  end

  test "fmap" do
    f = fn :value -> "value" end

    assert fmap({:ok, :value}, f) == {:ok, "value"}
  end

  test_monad(Result, {:ok, :value})

  test "pipe_bind" do
    f = fn :value -> {:ok, "value"} end

    assert pipe_bind({:ok, :value}, f) == {:ok, "value"}
    assert pipe_bind(:anything_else, f) == :anything_else
  end

  test "pipe_fmap" do
    f = fn :value -> "value" end

    assert pipe_fmap({:ok, :value}, f) == {:ok, "value"}
    assert pipe_fmap(:anything_else, f) == :anything_else
  end
end
