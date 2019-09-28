defmodule OkComputer.CaseTest do
  use ExUnit.Case
  import OkComputer.Case

  def ok?(value), do: value != nil
  def ok?(value), do: value != nil

  def bind(nil, f), do: nil
  def bind(a, f), do: f.(a)

  test "case_ok" do
    stringify = fn value ->
      case_ok value do
        value -> to_string(value)
      end
    end

    assert stringify.(nil) == nil
    assert stringify.(:anything_else) == "anything_else"
  end
end
