defmodule ErrorTest do
  use ExUnit.Case

  import Error

  use Monad.Laws

  test "return" do
    assert return(nil)           == {:error, nil}
    assert return({:ok, "a"})    == {:ok, "a"}
    assert return({:error, "a"}) == {:error, "a"}
    assert return("a")           == {:error, "a"}
  end

  test "bind" do
    assert bind({:ok, "a"},    fn a -> return "f(#{a})" end) == {:ok, "a"}
    assert bind({:error, "a"}, fn a -> return "f(#{a})" end) == {:error, "f(a)"}
  end

  test "ok" do
    assert ok "a" == {:ok, "a"}
  end

  test "error" do
    assert error "a" == {:error, "a"}
  end
end
