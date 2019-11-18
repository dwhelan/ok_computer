defmodule Math do
  @moduledoc false
  import Lily.Operator

  defoperators(
    +: fn
      {a, a_i} -> {+a, +a_i}
      a -> Kernel.+(a)
    end,
    +: fn
      {a, a_i}, {b, b_i} -> {a + b, a_i + b_i}
      a, b -> Kernel.+(a, b)
    end

    # ...
  )

  defmacro __using__(_) do
    quote do
      import Math
      import Kernel, except: [+: 1, +: 2]
    end
  end
end
