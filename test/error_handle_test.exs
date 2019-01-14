defmodule ErrorHandlerTest do
  use ExUnit.Case

  import ErrorHandler

  use Monad.Laws

  test "return" do
    assert return(nil)           == {:error, nil}
    assert return({:ok, 'v'})    == {:ok, 'v'}
    assert return({:error, 'v'}) == {:error, 'v'}
    assert return('v')           == {:error, 'v'}
  end

  test "bind" do
    assert bind({:ok, 'v'},    fn _ -> {:ok, 'f(v)'}    end) == {:ok, 'v'}
    assert bind({:error, 'v'}, fn _ -> {:error, 'f(v)'} end) == {:error, 'f(v)'}
  end
end
