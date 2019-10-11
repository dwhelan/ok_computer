defmodule OkComputer.Pipe.TrueTest do
  use ExUnit.Case
  import OkComputer.Pipe.True

  test "bind" do
    assert bind(nil, &to_string/1) == nil
    assert bind(false, &to_string/1) == false
    assert bind(:anything_else, &to_string/1) == "anything_else"
  end

  test "fmap" do
    assert fmap(nil, &to_string/1) == nil
    assert fmap(false, &to_string/1) == false
    assert fmap(:anything_else, &to_string/1) == "anything_else"
  end
end
