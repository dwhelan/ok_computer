defmodule OkComputer.OperatorTest do
  use ExUnit.Case
  import OkComputer.Operator

  def assert_operator_error_raise(string) do
    assert_raise(OkComputer.OperatorError, fn -> Code.eval_string(string) end)
  end

  describe "unary operators" do
    test "can't use ^" do
      assert_raise(OkComputer.OperatorError, fn ->
        create(:def, :^, quote(do: &to_string/1))
      end)
    end
  end

  describe "binary operators" do
    test "can't use ." do
      assert_raise(OkComputer.OperatorError, fn ->
        create(:def, :., quote(do: &apply/2))
      end)
    end

    test "can't use not in" do
      assert_raise(OkComputer.OperatorError, fn ->
        create(:def, :"not in", quote(do: &apply/2))
      end)
    end

    test "can't use =>" do
      assert_raise(OkComputer.OperatorError, fn ->
        create(:def, :"=>", quote(do: &apply/2))
      end)
    end

    test "can't use when" do
      assert_raise(OkComputer.OperatorError, fn ->
        create(:def, :when, quote(do: &apply/2))
      end)
    end
  end
end
