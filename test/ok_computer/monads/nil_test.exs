defmodule OkComputer.Monads.NilTest do
  use ExUnit.Case
  import Monad.Laws
  alias OkComputer.Monads.Nil
  import Nil

  test "return" do
    assert return(nil) == nil
    assert return(:anything_else) == :anything_else
  end

  test "bind" do
    assert bind(nil, &to_string/1) == ""
    assert bind(:anything_else, &to_string/1) == :anything_else
  end

  test_monad(Nil, nil)
end
