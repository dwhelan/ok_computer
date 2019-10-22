defmodule Functions do
  def plus(a, b) do
    quote do
      "plus(#{unquote(a)}, #{unquote(b)})"
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

  import Functions

  operators(
    +: {Functions, :plus},
    ~>: {Functions, :pipe},
    &&&: "~s/f_source(unquote(left), unquote(right))/"
  )

  import OkComputer.OperatorTest.Operators

  test "math operator" do
    assert :a + :b == "plus(a, b)"
  end

  test "pipe" do
    assert :a ~> to_string == "a"
  end

  test "from source" do
    assert :a &&& :b == "f_source(unquote(left), unquote(right))"
  end
end
