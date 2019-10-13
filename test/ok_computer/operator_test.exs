defmodule OkComputer.OperatorTest do
  use ExUnit.Case
  import OkComputer.Operator

  test "custom operator" do
    defoperators [<|>: "unquote(lhs) <> unquote(rhs)"]
    assert "a" <|> "b" == "ab"
  end
end
