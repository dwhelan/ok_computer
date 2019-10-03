defmodule OkComputer.Monad.NonNilTest do
  alias OkComputer.Monad.NonNil

  use ExUnit.Case
  import Monad.Laws
  import NonNil

  test "return" do
    assert return(nil) == nil
    assert return(:anything_else) == :anything_else
  end

  test "bind" do
    assert bind(nil, &to_string/1) == nil
    assert bind(:anything_else, &to_string/1) == "anything_else"
  end

  test_monad(NonNil, :anything_but_nil)
end
