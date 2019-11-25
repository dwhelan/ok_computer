defmodule OkComputer.Monad.OkTest do
  use ExUnit.Case
  alias OkComputer.Monad.Ok
  import Monad.Laws
  import Ok

  test "return" do
    assert return(:a) == {:ok, :a}
  end

  test "bind" do
    f = fn :a -> {:ok, "a"} end
    assert bind({:ok, :a}, f) == {:ok, "a"}
    assert bind({:error, :a}, f) == {:error, :a}
    assert bind(:a, f) == :a
  end

  test "fmap" do
    f = fn :a -> "a" end
    assert fmap({:ok, :a}, f) == {:ok, "a"}
    assert fmap({:error, :a}, f) == {:error, :a}
    assert fmap(:a, f) == :a
  end

  test "pipe" do
    pipe_fun = fn {:ok, :a}, f -> f.(:A) end
    f = fn :A -> {:ok, "A"} end

    assert pipe({:ok, :a}, f, pipe_fun) == {:ok, "A"}
    assert pipe({:error, :a}, f, pipe_fun) == {:error, :a}
    assert pipe(nil, f, pipe_fun) == nil
  end

  test_monad(Ok, {:ok, :a})
end
