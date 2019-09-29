defmodule OkComputer.PipesTest do
  use ExUnit.Case
  import OkComputer.Pipes
  alias OkComputer.Monads.{NonNil, Nil}

  defpipes NonNil, Nil

  test "ok pipe" do
    assert(nil ~> to_string() == nil)
    assert(:anything_else ~> to_string() == "anything_else")
  end

  test "error pipe" do
    assert(nil ~>> to_string() == "")
    assert(:anything_else ~>> to_string() == :anything_else)
  end
end
