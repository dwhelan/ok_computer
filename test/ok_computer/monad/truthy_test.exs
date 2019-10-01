defmodule OkComputer.Monad.TruthyTest do
  use ExUnit.Case
  import Monad.Laws
  alias OkComputer.Monad.Truthy
  import Truthy

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

  test "value_quoted" do
    assert value_quoted(:a) == :a
  end

  test_monad(Truthy, :anything_truthy)
end
