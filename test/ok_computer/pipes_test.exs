defmodule OkComputer.PipesTest do
  use ExUnit.Case
  import OkComputer.Pipes

  defpipes(
    OkComputer.Monads.NonNil,
    OkComputer.Monads.Nil
  )

  test "ok pipe" do
    assert(nil >>> to_string() == nil)
    assert(:anything_else >>> to_string() == "anything_else")
  end

  test "error pipe" do
    assert(nil <<< to_string() == "")
    assert(:anything_else <<< to_string() == :anything_else)
  end
end
