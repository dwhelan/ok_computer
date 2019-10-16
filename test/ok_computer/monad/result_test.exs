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

  test "map" do
    f = fn :value -> "value" end

    assert map({:ok, :value}, f) == {:ok, "value"}
  end

  test_monad(Result, {:ok, :value})

  test "pipe_bind" do
    f = fn :value -> {:ok, "value"} end

    assert bind({:ok, :value}, f) == {:ok, "value"}
    assert bind(:a, f) == :a
  end

  test "pipe_fmap" do
    f = fn :value -> "value" end

    assert map({:ok, :value}, f) == {:ok, "value"}
    assert map(:a, f) == :a
  end
end
