defmodule OkComputer.NonNilTest do
  use ExUnit.Case
  import OkComputer.NonNil

  test "bind" do
    assert bind(nil, &to_string/1) == nil
    assert bind(:anything_else, &to_string/1) == "anything_else"
  end
end
