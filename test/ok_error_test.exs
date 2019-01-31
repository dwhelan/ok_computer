defmodule OkErrorTest do
  use ExUnit.Case
  import OkComputerTest
  import OkError

  use Monad.Laws

  test "return" do
    assert return(nil)           == {:error, nil}
    assert return({:error, "a"}) == {:error, "a"}
    assert return({:ok, "a"})    == {:ok, "a"}
    assert return("a")           == {:ok, "a"}
  end

  test "bind" do
    assert bind({:ok, "a"},    fn a -> return "f(#{a})" end) == {:ok, "f(a)"}
    assert bind({:error, "a"}, fn a -> return "f(#{a})" end) == {:error, "a"}
  end

  test "ok" do
    assert ok "a" == {:ok, "a"}
  end

  test "error" do
    assert error "a" == {:error, "a"}
  end
end
