defmodule OkComputer.Operator.UnaryMacroTest do
  use ExUnit.Case
  import OkComputer.Operator

  def stringify(input), do: quote(do: "#{unquote(input)}")

  #  operator_macro :@, &__MODULE__.stringify/1
  operator_macro :@, fn input -> quote(do: "#{unquote(input)}") end
  operator_macro :+, fn input -> quote(do: "#{unquote(input)}") end
  operator_macro :-, fn input -> quote(do: "#{unquote(input)}") end
  operator_macro :!, fn input -> quote(do: "#{unquote(input)}") end
  operator_macro :not, fn input -> quote(do: "#{unquote(input)}") end
  operator_macro :~~~, fn input -> quote(do: "#{unquote(input)}") end

  test "@", do: assert(@:a == "a")
  test "+", do: assert(+:a == "a")
  test "-", do: assert(-:a == "a")
  test "!", do: assert(!:a == "a")
  test "not", do: assert(not :a == "a")
  test "~~~", do: assert(~~~:a == "a")
end
