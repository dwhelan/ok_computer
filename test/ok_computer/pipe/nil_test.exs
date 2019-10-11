defmodule OkComputer.Pipe.NilTest do
  use ExUnit.Case
  import OkComputer.Pipe.Nil

  test "bind" do
    assert bind(nil, &to_string/1) == ""
    assert bind(:anything_else, &to_string/1) == :anything_else
  end

  test "fmap" do
    assert fmap(nil, &to_string/1) == ""
    assert fmap(:anything_else, &to_string/1) == :anything_else
  end
end
