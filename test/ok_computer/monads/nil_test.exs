defmodule OkComputer.Monads.NilTest do
  use ExUnit.Case
  import OkComputer.Monads.Nil

  test "bind" do
    assert bind(nil, &to_string/1) == ""
    assert bind(:anything_else, &to_string/1) == :anything_else
  end
end
