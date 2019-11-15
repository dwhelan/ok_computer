defmodule Wrap do
  import Lily.Operator

  defoperators(@: fn a -> List.wrap(a) end)
end
