defmodule OkComputer.Pipe.FalseTest do
  use ExUnit.Case
  import OkComputer.Pipe.False

  test "pipe_bind" do
    assert pipe_bind(nil, &to_string/1) == ""
    assert pipe_bind(false, &to_string/1) == "false"
    assert pipe_bind(:anything_else, &to_string/1) == :anything_else
  end

  test "fmap" do
    assert pipe_fmap(nil, &to_string/1) == ""
    assert pipe_fmap(false, &to_string/1) == "false"
    assert pipe_fmap(:anything_else, &to_string/1) == :anything_else
  end
end
