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

  test "fmap" do
    f = fn :reason -> "reason" end

    assert fmap({:error, :reason}, f) == {:error, "reason"}
    #    assert fmap(:anything_else, f) == :anything_else
  end

  test_monad(Error, {:error, :reason})

  test "pipe_bind" do
    f = fn :value -> {:error, "value"} end

    assert bind({:error, :value}, f) == {:error, "value"}
    assert bind(:anything_else, f) == :anything_else
  end

  test "pipe_fmap" do
    f = fn :value -> "value" end

    assert fmap({:error, :value}, f) == {:error, "value"}
    assert fmap(:anything_else, f) == :anything_else
  end
end
