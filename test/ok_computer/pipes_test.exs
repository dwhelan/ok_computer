defmodule OkComputer.Operation.PipesTest do
  alias OkComputer.Monad.{NonNil, Nil}

  use ExUnit.Case
  import OkComputer.Operation.Pipe

  def monad_ok(), do: OkComputer.Monad.NonNil
  def monad_error(), do: OkComputer.Monad.Nil

  build(:foo, NonNil, :~>)
  build(:foo, Nil, :~>>)

  test "ok pipe" do
    assert(nil ~> to_string() == nil)
    assert(:anything_else ~> to_string() == "anything_else")
  end

  test "error pipe" do
    assert(nil ~>> to_string() == "")
    assert(:anything_else ~>> to_string() == :anything_else)
  end
end
