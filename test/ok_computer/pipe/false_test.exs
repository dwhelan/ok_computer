defmodule OkComputer.Pipe.FalseTest do
  use ExUnit.Case
  import OkComputer.Pipe.False

  test "bind" do
    assert bind(nil, &to_string/1) == ""
    assert bind(false, &to_string/1) == "false"
    assert bind(:anything_else, &to_string/1) == :anything_else
  end

  test "fmap" do
    assert fmap(nil, &to_string/1) == ""
    assert fmap(false, &to_string/1) == "false"
    assert fmap(:anything_else, &to_string/1) == :anything_else
  end
end
