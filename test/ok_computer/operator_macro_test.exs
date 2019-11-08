defmodule OkComputer.OperatorMacroTest do
  use ExUnit.Case
  import OkComputer.Operator

  operator_macro(:+, fn input ->
    quote do
      to_string(unquote(input))
    end
  end)

  test "+/1" do
    assert +:a == "a"
  end

  operator_macro(:+, fn left, right ->
    quote do
      to_string(unquote(left)) <> to_string(unquote(right))
    end
  end)

  test "+/2" do
    assert :a + :b == "ab"
  end
end
