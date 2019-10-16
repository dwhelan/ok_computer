defmodule OkComputer.Pipe.TrueTest do
  use ExUnit.Case
  import OkComputer.Pipe.True

  test "bind" do
    assert bind(nil, &to_string/1) == nil
    assert bind(false, &to_string/1) == false
    assert bind(:a, &to_string/1) == "a"
  end

  test "map" do
    assert map(nil, &to_string/1) == nil
    assert map(false, &to_string/1) == false
    assert map(:a, &to_string/1) == "a"
  end
end
