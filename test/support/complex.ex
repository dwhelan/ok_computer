defmodule Lily.Complex do
  import Lily.Operator

  operator :+, fn {a, a_i}, {b, b_i} -> {Kernel.+(a, b), Kernel.+(a_i, b_i)} end
  operator :-, fn {a, a_i}, {b, b_i} -> {Kernel.-(a, b), Kernel.-(a_i, b_i)} end

  defmacro __using__(opts \\ []) do
    quote do
      import Lily.Complex
      import Kernel, except: [+: 2, -: 2]
    end
  end
end
