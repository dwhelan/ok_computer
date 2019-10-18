defmodule Operators do
  def subtract(left, right) do
    left - right
  end

  defmacro multiply(left, right) do
    quote do
      unquote(left) * unquote(right)
    end
  end
end

defmodule OkComputer.OperatorTest do
  use ExUnit.Case
  import OkComputer.Operator

  import Kernel, except: [+: 2, -: 2, *: 2]

  doctest OkComputer.Operator

  operators(
    +: "unquote(left) + unquote(right)",
    -: {Operators, :subtract},
    *: {Operators, :multiply, :macro}
  )

  test "from source" do
    assert 1 + 2 == 3
  end

  test "from external function" do
    assert 1 - 2 == -1
  end

  test "from macro" do
    assert 2 * 3 == 6
  end
end
