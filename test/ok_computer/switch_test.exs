defmodule OkComputer.SwitchPipeTest do
  alias OkComputer.Monad.{Value, Nil}

  use ExUnit.Case
  import OkComputer.Switch

  build ~>: Value, ~>>: Nil

  test "value pipe" do
    assert :value ~> to_string() == "value"
  end

  test "nil pipe" do
    assert nil ~>> to_string() == ""
  end
end

defmodule OkComputer.SwitchOperatorTest do
  alias OkComputer.Monad.{Value, Nil}
  alias OkComputer.Operation.Case

  use ExUnit.Case
  import OkComputer.Switch

  build [Case], [Value, Nil]

  test "case_value" do
    assert(
      case_value :value do
        value -> to_string(value)
      end == "value"
    )
  end

  test "case_nil" do
    assert(
      case_nil nil do
        value -> to_string(value)
      end == ""
    )
  end
end

defmodule OkComputer.Switch.PipeAndOperatorTest do
  alias OkComputer.Monad.{Value, Nil}
  alias OkComputer.Operation.Case

  use ExUnit.Case
  import OkComputer.Switch

  build [Case], ~>: Value, ~>>: Nil

  test "value pipe" do
    assert :value ~> to_string() == "value"
  end

  test "nil pipe" do
    assert nil ~>> to_string() == ""
  end

  test "case_value" do
    assert(
      case_value :value do
        value -> to_string(value)
      end == "value"
    )
  end

  test "case_nil" do
    assert(
      case_nil nil do
        value -> to_string(value)
      end == ""
    )
  end
end
