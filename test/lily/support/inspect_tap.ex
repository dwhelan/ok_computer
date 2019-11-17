defmodule InspectTap do
  @moduledoc false
  import Lily.Operator

  defoperator_macros(~>: tap(&IO.inspect/1))
end
