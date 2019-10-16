defmodule OkComputer.Pipe.NilTest do
  use ExUnit.Case
  import OkComputer.Pipe.Nil

  test "bind" do
    assert bind(nil, &to_string/1) == ""
    assert bind(:a, &to_string/1) == :a
  end

  test "fmap" do
    assert fmap(nil, &to_string/1) == ""
    assert fmap(:a, &to_string/1) == :a
  end
end
