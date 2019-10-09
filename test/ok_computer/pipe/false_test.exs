defmodule OkComputer.Pipe.FalseTest do
  alias OkComputer.Pipe.False

  use ExUnit.Case
  import Monad.Laws
  import False

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

  test_monad(False, nil)
  test_monad(False, false)
#  test_monad(False, true)
end
