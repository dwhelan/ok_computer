defmodule IO.Inspect do
  @moduledoc false
  import Lily.Operator

  operator_macro(~>: tap(&IO.inspect/1))
end
