defmodule OkComputer.Monads.TruthyTest do
  use ExUnit.Case
  import OkComputer.Monads.Truthy

  test "bind" do
    assert bind(nil, &to_string/1) == nil
    assert bind(false, &to_string/1) == false
    assert bind(:anything_else, &to_string/1) == "anything_else"
  end
end
