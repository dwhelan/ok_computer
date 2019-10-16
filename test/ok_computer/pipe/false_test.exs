defmodule OkComputer.Pipe.FalseTest do
  use ExUnit.Case
  import OkComputer.Pipe.False

  test "bind" do
    assert bind(nil, &to_string/1) == ""
    assert bind(false, &to_string/1) == "false"
    assert bind(:a, &to_string/1) == :a
  end

  test "map" do
    assert map(nil, &to_string/1) == ""
    assert map(false, &to_string/1) == "false"
    assert map(:a, &to_string/1) == :a
  end
end
