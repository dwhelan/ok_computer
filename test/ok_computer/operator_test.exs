defmodule Operators do
  def subtract(left, right) do
    left - right
  end
end

defmodule OkComputer.OperatorTest do
  use ExUnit.Case
  import OkComputer.Operator

  import Kernel, except: [+: 2, -: 2]

  doctest OkComputer.Operator

  operators(
    +: "unquote(left) + unquote(right)",
    -: {Operators, :subtract}
  )

  #  test "custom operator for wrong math" do
  #    defoperators(+: "unquote(left) - unquote(right)")
  #    assert 1 + 2 == -1
  #  end

  test "from source" do
    assert 1 + 2 == 3
  end

  test "from external function" do
    assert 1 - 2 == -1
  end

  #  test "ast" do
  #    left = Macro.var(:left, nil)
  #    right = Macro.var(:right, nil)
  #
  #    ast =
  #      quote do
  #        unquote(left) + unquote(right)
  #      end
  #
  #    IO.inspect(ast: ast, s: Macro.to_string(ast))
  #  end
end
