defmodule Concat do
  @moduledoc false
  import Lily.Operator
  import Kernel, except: [+: 2, ++: 2]

  # Standard Elixir operator
  def a + b do
    "#{a}#{b}"
  end

  # Using defoperators
  defoperators(
    ++: fn a, b ->
      "#{a}#{b}"
    end
  )
end
