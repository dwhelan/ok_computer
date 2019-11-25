defmodule Wrap do
  @moduledoc false
  import Lily.Operator

  operator(@: fn a -> List.wrap(a) end)
end
