defmodule OkComputer.UnaryOperatorTest do
  use ExUnit.Case
  import OkComputer.Operator

  operator :@, fn input -> "#{input}" end
  operator :+, fn input -> "#{input}" end
  operator :-, fn input -> "#{input}" end
  operator :!, fn input -> "#{input}" end
  operator :not, fn input -> "#{input}" end
  operator :~~~, fn input -> "#{input}" end

  test "@", do: assert(@:a == "a")
  test "+/1", do: assert(+:a == "a")
  test "-/1", do: assert(-:a == "a")
  test "!", do: assert(!:a == "a")
  test "not", do: assert(not :a == "a")
  test "~~~", do: assert(~~~:a == "a")

  test "^/1" do
    assert_raise CompileError, ~r"cannot use \^a outside of match clauses", fn ->
      Code.eval_string("^a")
    end
  end
end
