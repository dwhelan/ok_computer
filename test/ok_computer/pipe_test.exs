defmodule OkComputer.PipeTest do
  alias OkComputer.Monad.{Value, Nil}

  use ExUnit.Case
  import OkComputer.Pipe

  build :~>, Value, :bind

  test "value pipe" do
    assert(nil ~> to_string() == nil)
    assert(:anything_else ~> to_string() == "anything_else")
  end

  build :~>>, Nil, :bind

  test "nil pipe" do
    assert(nil ~>> to_string() == "")
    assert(:anything_else ~>> to_string() == :anything_else)
  end
end
