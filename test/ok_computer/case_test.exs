defmodule OkComputer.CaseTest do
  use ExUnit.Case

  import OkComputer.Case

  def monad_ok(), do: OkComputer.Monad.NonNil
  def error_monad(), do: OkComputer.Monad.Nil

  case_(:ok, OkComputer.Monad.NonNil)

  test "case_ok" do
    stringify = fn value ->
      case_ok value do
        value -> to_string(value)
      end
    end

    assert stringify.(nil) == nil
    assert stringify.(:anything_else) == "anything_else"
  end

  case_(:error, OkComputer.Monad.NonNil)

  test "case_error" do
    stringify = fn value ->
      case_error value do
        value -> to_string(value)
      end
    end

    assert stringify.(nil) == ""
    assert stringify.(:anything_else) == :anything_else
  end
end
