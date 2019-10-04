defmodule OkComputer.Operation.PipeTest do
  alias OkComputer.Monad.{NonNil, Nil}

  use ExUnit.Case
  import OkComputer.Operation.Pipe

  build(:~>, NonNil)
  build(:~>>, Nil)

  test "ok pipe" do
    assert(nil ~> to_string() == nil)
    assert(:anything_else ~> to_string() == "anything_else")
  end

  test "error pipe" do
    assert(nil ~>> to_string() == "")
    assert(:anything_else ~>> to_string() == :anything_else)
  end
end
