defmodule OkComputer.OperatorTest do
  use ExUnit.Case

  def assert_operator_error_raise(string) do
    assert_raise(OkComputer.OperatorError, fn -> Code.eval_string(string) end)
  end

  describe "unary operators" do
    test "can't use '^'" do
      assert_operator_error_raise(~S"""
      defmodule OkComputer.BadOperator do
        import OkComputer.Operator
        operator :^, fn input -> input end
      end
      """)
    end
  end

  describe "binary operators" do
    test "can't use '.'" do
      assert_operator_error_raise(~S"""
      defmodule OkComputer.BadOperator do
        import OkComputer.Operator
        operator :".", fn left, right -> "#{left}#{right}"  end
      end
      """)
    end

    test "can't use 'not in'" do
      assert_operator_error_raise(~S"""
      defmodule OkComputer.BadOperator do
        import OkComputer.Operator
        operator :"not in", fn left, right -> "#{left}#{right}"  end
      end
      """)
    end

    test "can't use '=>'" do
      assert_operator_error_raise(~S"""
      defmodule OkComputer.BadOperator do
        import OkComputer.Operator
        operator :"=>", fn left, right -> "#{left}#{right}"  end
      end
      """)
    end

    test "can't use 'when'" do
      assert_operator_error_raise(~S"""
      defmodule OkComputer.BadOperator do
        import OkComputer.Operator
        operator :when, fn left, right -> "#{left}#{right}"  end
      end
      """)
    end
  end
end
