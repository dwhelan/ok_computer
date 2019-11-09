defmodule OkComputer.UnaryOperatorTest do
  use ExUnit.Case
  import OkComputer.Operator

  operator :@, fn input -> to_string(input) end
  operator :+, fn input -> to_string(input) end
  operator :-, fn input -> to_string(input) end
  operator :!, fn input -> to_string(input) end
  operator :not, fn input -> to_string(input) end
  operator :~~~, fn input -> to_string(input) end

  test "@/1", do: assert(@:a == "a")
  test "+/1", do: assert(+:a == "a")
  test "-/1", do: assert(-:a == "a")
  test "!/1", do: assert(!:a == "a")
  test "not/1", do: assert(not :a == "a")
  test "~~~/1", do: assert(~~~:a == "a")

  assert_raise CompileError, ~r"cannot use \^a outside of match clauses", fn ->
    Code.eval_string("^a")
  end
end
