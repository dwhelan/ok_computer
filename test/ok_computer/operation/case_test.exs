defmodule OkComputer.Operation.CaseTest do
  alias OkComputer.Monad.Value

  use ExUnit.Case
  import OkComputer.Operation.Case

  build Value

  test "case_value" do
    assert(
      case_value :value do
        value -> to_string(value)
      end == "value"
    )
  end
end
