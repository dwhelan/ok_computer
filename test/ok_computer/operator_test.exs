defmodule Operators do
  def add(left, right) do
    quote do
      unquote(left) + unquote(right)
    end
  end
end

defmodule OkComputer.OperatorTest do
  use ExUnit.Case
  import OkComputer.Operator
  import Kernel, except: [+: 2]

  doctest OkComputer.Operator

  test "custom operator for wrong math" do
    defoperators(+: "unquote(left) - unquote(right)")
    assert 1 + 2 == -1
  end

  test "foo" do
    left = Macro.var(:left, nil)
    right = Macro.var(:right, nil)

    ast =
      quote do
        unquote(left) + unquote(right)
      end

    IO.inspect(ast: ast, s: Macro.to_string(ast))
  end
end
