defmodule OkComputer.OperatorTest do
  use ExUnit.Case
  import OkComputer.Operator
  alias OkComputer.OperatorError

  describe "type" do
    test "raise if type is not :def or :defmacro" do
      assert_raise(OperatorError, fn ->
        create(:foo, :+, quote(do: &to_string/1))
      end)
    end
  end

  describe "atom" do
    test ~S/raise if in [:., :"=>", :^, :"not in", :when]/ do
      Enum.each([:., :"=>", :^, :"not in", :when], fn atom ->
        assert_raise(OperatorError, ~r/parser/, fn ->
          create(:def, atom, quote(do: &to_string/1))
        end)
      end)
    end

    test "raise if atom is not an operator" do
      assert_raise(OperatorError, fn ->
        create(:def, :foo, quote(do: &to_string/1))
      end)
    end
  end
end
