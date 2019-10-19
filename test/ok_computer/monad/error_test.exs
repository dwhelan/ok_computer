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
    assert bind(:anything_else, f) == :anything_else
  end

  test "map" do
    f = fn :reason -> "reason" end

    assert map({:error, :reason}, f) == {:error, "reason"}
    assert map(:anything_else, f) == :anything_else
  end

  test_monad(Error, {:error, :reason})
end
