defmodule Lily.Complex do
  import Lily.Operator

  operator :+, fn {a, a_i}, {b, b_i} -> {Kernel.+(a, b), Kernel.+(a_i, b_i)} end
  operator :-, fn {a, a_i}, {b, b_i} -> {Kernel.-(a, b), Kernel.-(a_i, b_i)} end

  # ...
end
