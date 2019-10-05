defmodule OkComputer.Operation.CaseTest do
  use ExUnit.Case
  import OkComputer.Operation.Case

  build(:ok, OkComputer.Monad.Value)

  test "case_ok" do
    stringify = fn value ->
      case_ok value do
        value -> to_string(value)
      end
    end

    assert stringify.(nil) == nil
    assert stringify.(:anything_else) == "anything_else"
  end

  build(:error, OkComputer.Monad.Nil)

  test "case_error" do
    stringify = fn value ->
      case_error value do
        value -> to_string(value)
      end
    end

    assert stringify.(nil) == ""
    assert stringify.(:anything_else) == :anything_else
  end

  build(nil, OkComputer.Monad.Nil)

  test "case_nil" do
    stringify = fn value ->
      case_nil value do
        value -> to_string(value)
      end
    end

    assert stringify.(nil) == ""
    assert stringify.(:anything_else) == :anything_else
  end
end
