defmodule OkComputer.Monads.FalseyTest do
  use ExUnit.Case
  import OkComputer.Monads.Falsey

  test "bind" do
    assert bind(nil, &to_string/1) == ""
    assert bind(false, &to_string/1) == "false"
    assert bind(:anything_else, &to_string/1) == :anything_else
  end
end
