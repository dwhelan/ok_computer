defmodule OkComputer.Pipe.FalseTest do
  use ExUnit.Case
  import OkComputer.Pipe.False

  test "bind" do
    assert bind(nil, &to_string/1) == ""
    assert bind(false, &to_string/1) == "false"
    assert bind(:a, &to_string/1) == :a
  end

  test "fmap" do
    assert fmap(nil, &to_string/1) == ""
    assert fmap(false, &to_string/1) == "false"
    assert fmap(:a, &to_string/1) == :a
  end
end
