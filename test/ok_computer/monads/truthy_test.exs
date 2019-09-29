defmodule OkComputer.Monads.TruthyTest do
  use ExUnit.Case
  import Monad.Laws
  alias OkComputer.Monads.Truthy
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

  test_monad(Truthy, "a")
end
