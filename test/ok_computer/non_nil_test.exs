defmodule OkComputer.NonNilTest do
  use ExUnit.Case
  import OkComputer.NonNil

  doctest OkComputer.NonNil

  test "case_ok" do
    f = fn value ->
      case_ok value do
        1 -> "one"
        2 -> "two"
        3 -> "three"
      end
    end

    assert f.(nil) == nil
    assert f.(1) == "one"
    assert f.(2) == "two"
    assert f.(3) == "three"

    x = 1
    assert f.(x) == "one"

    assert_raise CaseClauseError, fn -> f.(4) end
  end
end
