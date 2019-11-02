defmodule OkComputer.Operator.PlusTest do
  use ExUnit.Case
  import OkComputer.NewOperator

  operator :+, &to_string(&1)

  test "+/1" do
    assert +:a == "a"
  end

  operator :+, &(to_string(&1) <> to_string(&2))

  test "+/2" do
    assert :a + :b == "ab"
  end
end

defmodule OkComputer.Operator.PlusMacroTest do
  use ExUnit.Case
  import OkComputer.NewOperator

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
