defmodule OkComputer.Pipe.NilTest do
  use ExUnit.Case
  import OkComputer.Pipe.Nil

  test "pipe_bind" do
    assert pipe_bind(nil, &to_string/1) == ""
    assert pipe_bind(:anything_else, &to_string/1) == :anything_else
  end

  test "pipe_fmap" do
    assert pipe_fmap(nil, &to_string/1) == ""
    assert pipe_fmap(:anything_else, &to_string/1) == :anything_else
  end
end
