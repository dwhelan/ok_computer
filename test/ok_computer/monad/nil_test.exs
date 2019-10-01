defmodule OkComputer.Monad.NilTest do
  use ExUnit.Case
  alias OkComputer.Monad.Nil
  import Monad.Laws
  import Nil

  test "return" do
    assert return(nil) == nil
    assert return(:anything_else) == :anything_else
  end

  test "bind" do
    assert bind(nil, &to_string/1) == ""
    assert bind(:anything_else, &to_string/1) == :anything_else
  end

  test "value_quoted" do
    assert value_quoted(nil) == nil
  end

  test_monad(Nil, nil)
end