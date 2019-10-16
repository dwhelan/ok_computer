defmodule OkComputer.Pipe.ValueTest do
  use ExUnit.Case
  import OkComputer.Pipe.Value

  test "bind" do
    assert bind(nil, &to_string/1) == nil
    assert bind(:a, &to_string/1) == "a"
  end

  test "map" do
    assert map(nil, &to_string/1) == nil
    assert map(:a, &to_string/1) == "a"
  end
end
