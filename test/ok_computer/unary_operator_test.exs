defmodule OkComputer.UnaryOperatorTest do
  use ExUnit.Case
  import OkComputer.Test
  import OkComputer.Operator

  operator :@, fn input -> "#{input}" end
  operator :+, fn input -> "#{input}" end
  operator :-, fn input -> "#{input}" end
  operator :!, fn input -> "#{input}" end
  operator :not, fn input -> "#{input}" end
  operator :~~~, fn input -> "#{input}" end

  test "@", do: assert(@:a == "a")
  test "+", do: assert(+:a == "a")
  test "-", do: assert(-:a == "a")
  test "!", do: assert(!:a == "a")
  test "not", do: assert(not :a == "a")
  test "~~~", do: assert(~~~:a == "a")

  test "can't use '^'" do
    assert_operator_error_raise(
      :^,
      ~S"""
      defmodule OkComputer.BadOperator do
        import OkComputer.Operator
        operator :^, fn input -> "#{input}"  end
      end
      """
    )
  end
end
