defmodule OkComputer.Operation do
  @moduledoc """
  Builds operations for a monad.
  """
  @macrocallback build(atom, module) :: Macro.t()
end
