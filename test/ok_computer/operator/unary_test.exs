defmodule OkComputer.Operator.UnaryTest do
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
end
