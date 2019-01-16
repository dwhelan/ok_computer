defmodule OkErrorTest do
  use ExUnit.Case

  import OkError

  use Monad.Laws

  test "return" do
    assert return(nil)           == {:error, nil}
    assert return({:ok, "a"})    == {:ok, "a"}
    assert return({:error, "a"}) == {:error, "a"}
    assert return("a")           == {:ok, "a"}
  end

  test "bind" do
    assert bind({:ok, "a"},    fn a -> return "f(#{a})" end) == {:ok, "f(a)"}
    assert bind({:error, "a"}, fn a -> return "f(#{a})" end) == {:error, "a"}
  end

  test "ok" do
    assert ok "a" == return "a"
  end
end
