defmodule OkComputer.Monad.ValueTest do
  alias OkComputer.Monad.Value

  use ExUnit.Case
  import Monad.Laws
  import Value

  test "return" do
    assert return(nil) == nil
    assert return(:anything_else) == :anything_else
  end

  test "bind" do
    assert bind(nil, &to_string/1) == nil
    assert bind(:anything_else, &to_string/1) == "anything_else"
  end

  test_monad(Value, :anything_but_nil)
end
