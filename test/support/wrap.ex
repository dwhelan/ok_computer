defmodule Wrap do
  import Lily.Operator

  operators(
    @: fn a -> List.wrap(a) end
  )
end
