defmodule OkComputer.Operator.PlusTest do
  use ExUnit.Case
  import OkComputer.Operator

  operator2 :+, fn input -> to_string(input) end

  test "+/1" do
    assert +:a == "a"
  end

  operator2 :+, fn left, right -> to_string(left) <> to_string(right) end

  test "+/2" do
    assert :a + :b == "ab"
  end
end

defmodule OkComputer.Operator.PlusMacroTest do
  use ExUnit.Case
  import OkComputer.Operator

  operator_macro2(:+, fn input ->
    quote do
      to_string(unquote(input))
    end
  end)

  test "+/1" do
    assert +:a == "a"
  end

  operator_macro2(:+, fn left, right ->
    quote do
      to_string(unquote(left)) <> to_string(unquote(right))
    end
  end)

  test "+/2" do
    assert :a + :b == "ab"
  end
end
