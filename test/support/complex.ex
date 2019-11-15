defmodule Complex do
  import Lily.Operator

  defoperators(
    +: fn {a, a_i}, {b, b_i} -> {Kernel.+(a, b), Kernel.+(a_i, b_i)} end,
    -: fn {a, a_i}, {b, b_i} -> {Kernel.-(a, b), Kernel.-(a_i, b_i)} end
  )

  # ...
end
