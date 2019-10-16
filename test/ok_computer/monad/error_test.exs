defmodule OkComputer.Monad.ErrorTest do
  use ExUnit.Case
  alias OkComputer.Monad.Error
  import Monad.Laws
  import Error

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
    #    assert map(:a, f) == :a
  end

  test_monad(Error, {:error, :reason})

  test "pipe_bind" do
    f = fn :value -> {:error, "value"} end

    assert bind({:error, :value}, f) == {:error, "value"}
    assert bind(:a, f) == :a
  end

  test "pipe_fmap" do
    f = fn :value -> "value" end

    assert map({:error, :value}, f) == {:error, "value"}
    assert map(:a, f) == :a
  end
end
