defmodule Operators do
  def f(a, b) do
    "f(#{a}, #{b})"
  end

  defmacro f_macro(a, b) do
    quote bind_quoted: [a: a, b: b] do
      "f_macro(#{a}, #{b})"
    end
  end
end

defmodule OkComputer.OperatorTest do
  use ExUnit.Case
  import OkComputer.Operator

  import Kernel, except: [+: 2, -: 2, *: 2]

  doctest OkComputer.Operator

  operators(
    +: {Operators, :f},
    -: {Operators, :f_macro, :macro},
    *: &Operators.f/2,
    &&&: "~s/f_source(unquote(left), unquote(right))/"
  )

  test "from named external function" do
    assert :a + :b == "f(a, b)"
  end

  test "from external function" do
    assert :a * :b == "f(a, b)"
  end

  test "from macro" do
    assert :a - :b == "f_macro(a, b)"
  end

  test "from source" do
    assert :a &&& :b == "f_source(unquote(left), unquote(right))"
  end
end
