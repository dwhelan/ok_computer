defmodule OkComputer.Monad.ErrorTest do
  alias OkComputer.Monad.Error

  use ExUnit.Case
  import Monad.Laws
  import Error

  test "return" do
    assert return(:reason) == {:error, :reason}
  end

  test "bind" do
    f = fn :reason -> {:error, "reason"} end

    assert bind({:error, :reason}, f) == {:error, "reason"}
    assert bind(:anything_else, f) == :anything_else
  end

  test "fmap" do
    f = fn :reason -> "reason" end

    assert fmap({:error, :reason}, f) == {:error, "reason"}
    assert fmap(:anything_else, f) == :anything_else
  end

  test_monad(Error, :reason)
  test_monad(Error, nil)
end
