defmodule OkComputer.Operation.CaseTest do
  alias OkComputer.Pipe.Value

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

defmodule OkComputer.Operation.CaseWithWrapperTest do
  alias OkComputer.Pipe.Value

  use ExUnit.Case
  import OkComputer.Operation.Case

  def wrap({:ok, a}), do: {:ok, a}
  def wrap(a), do: {:ok, a}

  def unwrap({:ok, a}), do: a
  def unwrap(a), do: a

  build Value, __MODULE__

  test "case_value" do
    assert(
      case_value :value do
        a -> to_string(a)
      end == {:ok, "value"}
    )

    assert(
      case_value :value do
        a -> {:ok, to_string(a)}
      end == {:ok, "value"}
    )
  end
end
