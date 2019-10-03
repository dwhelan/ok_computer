defmodule OkComputer.Monad.TrueTest do
  alias OkComputer.Monad.True

  use ExUnit.Case
  import Monad.Laws
  import True

  test "return" do
    assert return(nil) == nil
    assert return(false) == false
    assert return(:anything_else) == :anything_else
  end

  test "bind" do
    assert bind(nil, &to_string/1) == nil
    assert bind(false, &to_string/1) == false
    assert bind(:anything_else, &to_string/1) == "anything_else"
  end

  test "wrap" do
    assert wrap(nil) == nil
    assert wrap(false) == false
    assert wrap(:anything_else) == :anything_else
  end

  test_monad(True, :anything_truthy)
end