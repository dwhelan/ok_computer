defmodule ErrorHandlerTest do
  use ExUnit.Case

  import ErrorHandler

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
end
