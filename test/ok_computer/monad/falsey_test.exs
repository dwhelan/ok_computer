defmodule OkComputer.Monad.FalseyTest do
  use ExUnit.Case
  import Monad.Laws
  alias OkComputer.Monad.Falsey
  import Falsey

  test "return" do
    assert return(nil) == nil
    assert return(false) == false
    assert return(:anything_else) == :anything_else
  end

  test "bind" do
    assert bind(nil, &to_string/1) == ""
    assert bind(false, &to_string/1) == "false"
    assert bind(:anything_else, &to_string/1) == :anything_else
  end

  test "value_quoted" do
    assert value_quoted(false) == false
  end

  test_monad(Falsey, nil)
  test_monad(Falsey, false)
end
