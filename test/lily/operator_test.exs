defmodule Lily.OperatorTest do
  use ExUnit.Case
  alias Lily.{Operator, Error}
  import Operator

  doctest Operator

  describe "type" do
    test "raise if type is not :def or :defmacro" do
      assert_raise(Error, ~r/expected type to be :def or :defmacro/, fn ->
        create(:foo, :+, quote(do: &to_string/1))
      end)
    end
  end

  describe "atom" do
    test ~S/raise if in [:., :"=>", :^, :"not in", :when]/ do
      Enum.each([:., :"=>", :^, :"not in", :when], fn atom ->
        assert_raise(Error, ~r/used by the Elixir parser/, fn ->
          create(:def, atom, quote(do: &to_string/1))
        end)
      end)
    end

    test "raise if atom is not an operator" do
      assert_raise(Error, ~r/expected an operator/, fn ->
        create(:def, :foo, quote(do: &to_string/1))
      end)
    end
  end
end
