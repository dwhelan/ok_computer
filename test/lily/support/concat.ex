defmodule Concat do
  @moduledoc false
  import Lily.Operator

  # standard operator
  def a >>> b do
    "#{a}#{b}"
  end

  # lily operator
  defoperators(
    <<<: fn a, b ->
      "#{a}#{b}"
    end
  )
end
