defmodule OkComputer.OperatorTest do
  use ExUnit.Case
  import OkComputer.Operator
  import Kernel, except: [+: 2]

  doctest OkComputer.Operator

  test "custom operator for wrong math" do
    defoperators(+: "unquote(lhs) - unquote(rhs)")
    assert 1 + 2 == -1
  end
end
