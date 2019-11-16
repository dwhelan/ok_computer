defmodule Wrap do
  @moduledoc false
  import Lily.Operator

  defoperators(@: fn a -> List.wrap(a) end)
end
