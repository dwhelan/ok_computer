defmodule OkComputer.Operator.AtTest do
  use ExUnit.Case
  import OkComputer.NewOperator

  operator :@, &to_string(&1)

  test "@/1" do
    assert @:a == "a"
  end
end

defmodule OkComputer.Operator.AtMacroTest do
  use ExUnit.Case
  import OkComputer.NewOperator

  operator_macro(:@, fn input ->
    quote do
      to_string(unquote(input))
    end
  end)

  test "@" do
    assert @:a == "a"
  end
end
