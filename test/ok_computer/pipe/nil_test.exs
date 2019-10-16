defmodule OkComputer.Pipe.NilTest do
  use ExUnit.Case
  import OkComputer.Pipe.Nil

  test "bind" do
    assert bind(nil, &to_string/1) == ""
    assert bind(:a, &to_string/1) == :a
  end

  test "map" do
    assert map(nil, &to_string/1) == ""
    assert map(:a, &to_string/1) == :a
  end
end
