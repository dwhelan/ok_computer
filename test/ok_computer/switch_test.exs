defmodule OkComputer.SwitchPipeTest do
  alias OkComputer.Pipe.{Value, Nil}

  use ExUnit.Case
  import OkComputer.Switch

  #  build ~>: Value, ~>>: Nil
  #
  #  test "value pipe" do
  #    assert :value ~> to_string() == "value"
  #  end
  #
  #  test "nil pipe" do
  #    assert nil ~>> to_string() == ""
  #  end
end
