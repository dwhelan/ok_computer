defmodule OkComputer.PipesTest do
  use ExUnit.Case
  import OkComputer.Pipe

  def monad_ok(), do: OkComputer.Monad.NonNil
  def error_monad(), do: OkComputer.Monad.Nil

  pipe()

  test "ok pipe" do
    assert(nil ~> to_string() == nil)
    assert(:anything_else ~> to_string() == "anything_else")
  end

  test "error pipe" do
    assert(nil ~>> to_string() == "")
    assert(:anything_else ~>> to_string() == :anything_else)
  end
end
