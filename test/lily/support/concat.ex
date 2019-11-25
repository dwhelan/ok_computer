defmodule Concat do
  @moduledoc false
  import Lily.Operator

  # standard operator
  def a >>> b do
    "#{a}#{b}"
  end

  # lily operator
  operator(
    <<<: fn a, b ->
      "#{a}#{b}"
    end
  )
end
