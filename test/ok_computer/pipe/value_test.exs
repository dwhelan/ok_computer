defmodule OkComputer.Pipe.ValueTest do
  use ExUnit.Case
  import OkComputer.Pipe.Value

  test "bind" do
    assert bind(nil, &to_string/1) == nil
    assert bind(:anything_else, &to_string/1) == "anything_else"
  end

  test "fmap" do
    assert fmap(nil, &to_string/1) == nil
    assert fmap(:anything_else, &to_string/1) == "anything_else"
  end
end
