defmodule OkComputer.Monads.NonNilTest do
  use ExUnit.Case
  import Monad.Laws
  alias OkComputer.Monads.NonNil
  import NonNil

  test "return" do
    assert return(nil) == nil
    assert return(:anything_else) == :anything_else
  end

  test "bind" do
    assert bind(nil, &to_string/1) == nil
    assert bind(:anything_else, &to_string/1) == "anything_else"
  end

  test_monad(NonNil, "a")
end
