defmodule ErrorTest do
  use ExUnit.Case

  import Error

  use Monad.Laws

  test "return" do
    assert return(nil)           == {:error, nil}
    assert return({:ok, "v"})    == {:ok, "v"}
    assert return({:error, "v"}) == {:error, "v"}
    assert return("v")           == {:ok, "v"}
  end

  test "bind" do
    assert bind({:ok, "v"},    fn _ -> {:ok, "V"} end) == {:ok, "V"}
    assert bind({:error, "v"}, fn _ -> {:ok, "V"} end) == {:error, "v"}
  end
end
