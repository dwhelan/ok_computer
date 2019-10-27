defmodule Functions do
  def plus(a, b) do
    quote do
      unquote(a) + unquote(b)
    end
  end

  def pipe(left, right) do
    quote do
      unquote(left) |> unquote(right)
    end
  end
end

defmodule OkComputer.OperatorTest do
  use ExUnit.Case
  import OkComputer.Operator
  import Kernel, except: [+: 2]

  doctest OkComputer.Operator

  operators(Functions, plus: :+, pipe: :~>)

  import OkComputer.OperatorTest.Operators

  test "math operator" do
    assert 1 + 2 == 3
  end

  test "pipe" do
    assert :a ~> to_string == "a"
  end
end
