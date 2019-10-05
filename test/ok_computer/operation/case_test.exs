defmodule OkComputer.Operation.CaseTest do
  use ExUnit.Case
  import OkComputer.Operation.Case

  build(OkComputer.Monad.Value)

  test "case_value" do
    assert(
      case_value :value do
        value -> to_string(value)
      end == "value"
    )
  end
end
