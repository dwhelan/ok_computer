defmodule Lily.Operator.Complex do
  import Lily.Operator

  operator :+, fn {a, a_i}, {b, b_i} -> {Kernel.+(a, b), Kernel.+(a_i, b_i)} end
  operator :-, fn {a, a_i}, {b, b_i} -> {Kernel.-(a, b), Kernel.-(a_i, b_i)} end
end

defmodule Lily.Operator.ComplexTest do
  use ExUnit.Case
  import Kernel, except: [+: 2, -: 2]
  import Lily.Operator.Complex

  test ":+/2", do: assert({1, 2} + {3, 4} == {4, 6})
  test ":-/2", do: assert({1, 2} - {3, 4} == {-2, -2})
end
