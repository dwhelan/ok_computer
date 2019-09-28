defmodule OkComputer.CaseTest do
  use ExUnit.Case
  import OkComputer.Case

  def ok?(value), do: value != nil

  test "case_ok" do
    f = fn value ->
      case_ok value do
        value -> to_string(value)
      end
    end

    assert f.(nil) == nil
    assert f.(:anything_else) == "anything_else"
  end
end
