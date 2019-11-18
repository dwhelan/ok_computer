defmodule Lily.FunctionTest do
  use ExUnit.Case
  alias Lily.Function
  import Function

  describe "arity/2" do
    test "raise if f is an invalid quoted expression" do
      assert_raise(
        CompileError,
        ~r/invalid quoted expression/,
        fn -> arity({:invalid_quoted_expression}, __ENV__) end
      )
    end

    test "raise if quoted is not a function" do
      assert_raise(
        ArgumentError,
        fn -> arity(quote(do: :not_a_function), __ENV__) end
      )
    end
  end
end
