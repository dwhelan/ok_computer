defmodule OkComputer.PipesTest do
  use ExUnit.Case
  import OkComputer.Pipe

  def ok_monad(), do: OkComputer.Monads.NonNil
  def error_monad(), do: OkComputer.Monads.Nil

  monadic_pipe

  test "ok pipe" do
    assert(nil ~> to_string() == nil)
    assert(:anything_else ~> to_string() == "anything_else")
  end

  test "error pipe" do
    assert(nil ~>> to_string() == "")
    assert(:anything_else ~>> to_string() == :anything_else)
  end
end
