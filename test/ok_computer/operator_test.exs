defmodule OkComputer.OperatorTest do
  use ExUnit.Case
  import OkComputer.Test
  import OkComputer.Operator

  describe "unary operators" do
    test "can't use '^'" do
      assert_operator_error_raise(~S"""
      defmodule OkComputer.BadOperator do
        import OkComputer.Operator
        operator_macro :^, & &1
      end
      """)
    end
  end

  describe "binary operators" do
    test "can't use '.'" do
      assert_operator_error_raise(~S"""
      defmodule OkComputer.BadOperator do
        import OkComputer.Operator
        operator :".", fn left, right -> "#{left}#{right}" end
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
