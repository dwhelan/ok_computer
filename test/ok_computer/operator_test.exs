defmodule Operators do
  def f(a, b) do
    "f(#{a}, #{b})"
  end

  defmacro g(a, b) do
    quote bind_quoted: [a: a, b: b] do
      "g(#{a}, #{b})"
    end
  end
end

defmodule OkComputer.OperatorTest do
  use ExUnit.Case
  import OkComputer.Operator

  import Kernel, except: [+: 2, -: 2, *: 2, /: 2]

  doctest OkComputer.Operator

  import Operators

  operators(
    +: &Operators.f/2,
    -: &Operators.g/2,
    *: fn a, b -> "h(#{a}, #{b})" end,
    /: & "i(#{&1}, #{&2})",
    &&&: "~s/f_source(unquote(left), unquote(right))/"
  )

  test "external function" do
    assert :a + :b == "f(a, b)"
  end

  test "macro" do
    assert :a - :b == "g(a, b)"
  end

  test "local function" do
    assert :a * :b == "h(a, b)"
  end

  test "local capture" do
    assert :a / :b == "i(a, b)"
  end

  test "from source" do
    assert :a &&& :b == "f_source(unquote(left), unquote(right))"
  end
end
