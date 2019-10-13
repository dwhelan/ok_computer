defmodule OkComputer.Pipe.TrueTest do
  use ExUnit.Case
  import OkComputer.Pipe.True

  test "pipe_bind" do
    assert pipe_bind(nil, &to_string/1) == nil
    assert pipe_bind(false, &to_string/1) == false
    assert pipe_bind(:anything_else, &to_string/1) == "anything_else"
  end

  test "pipe_fmap" do
    assert pipe_fmap(nil, &to_string/1) == nil
    assert pipe_fmap(false, &to_string/1) == false
    assert pipe_fmap(:anything_else, &to_string/1) == "anything_else"
  end
end
