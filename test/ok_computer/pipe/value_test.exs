defmodule OkComputer.Pipe.ValueTest do
  use ExUnit.Case
  import OkComputer.Pipe.Value

  test "bind" do
    assert bind(nil, &to_string/1) == nil
    assert bind(:a, &to_string/1) == "a"
  end

  test "fmap" do
    assert fmap(nil, &to_string/1) == nil
    assert fmap(:a, &to_string/1) == "a"
  end
end
