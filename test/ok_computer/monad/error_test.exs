defmodule OkComputer.Monad.ErrorTest do
  use ExUnit.Case
  alias OkComputer.Monad.Error
  import Error
  import Monad.Laws

  test "return" do
    assert return(:a) == {:error, :a}
  end

  test "bind" do
    f = fn :a -> {:error, "a"} end
    assert bind({:error, :a}, f) == {:error, "a"}
    assert bind({:ok, :a}, f) == {:ok, :a}
  end

  test "fmap" do
    f = fn :a -> "a" end
    assert fmap({:error, :a}, f) == {:error, "a"}
    assert fmap({:ok, :a}, f) == {:ok, :a}
  end


  test "pipe" do
    pipe_fun = fn {:error, :a}, f -> f.(:A) end
    f = fn :A -> {:error, "A"} end

    assert pipe({:error, :a}, f, pipe_fun) == {:error, "A"}
    assert pipe({:ok, :a}, f, pipe_fun) == {:ok, :a}
    assert pipe(nil, f, pipe_fun) == nil
  end

  test_monad(Error, {:error, :a})
end
