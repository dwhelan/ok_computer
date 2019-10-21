defmodule OperatorFunctions do
  def f(a, b) do
    quote do
      "f(#{unquote a}, #{unquote b})"
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

  import Kernel, except: [+: 2, -: 2, *: 2, /: 2, <|>: 2]

  doctest OkComputer.Operator

  import OperatorFunctions

  operators(
    +: {OperatorFunctions, :f},
    ~>: {OperatorFunctions, :pipe},
    &&&: "~s/f_source(unquote(left), unquote(right))/"
  )

  import Operators

  test "external function" do
    assert :a + :b == "f(a, b)"
  end

  test "pipe" do
    assert :a ~> to_string == "a"
  end

  test "from source" do
    assert :a &&& :b == "f_source(unquote(left), unquote(right))"
  end
end
