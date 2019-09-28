defmodule OkComputer.CoreTest do
  use ExUnit.Case
  import OkComputer.Core

  doctest OkComputer.Core

  #  def ok?(value) do
  #    value < 10
  #  end
  #
  #  test "case_ok" do
  #    f = fn value ->
  #      case_ok value do
  #        1 -> "one"
  #        2 -> "two"
  #        3 -> "three"
  #      end
  #    end
  #
  #    assert f.(nil) == nil
  #    assert f.(false) == false
  #    assert f.(1) == "one"
  #    assert f.(2) == "two"
  #    assert f.(3) == "three"
  #
  #    x = 1
  #    assert f.(x) == "one"
  #
  #    assert_raise CaseClauseError, fn -> f.(4) end
  #  end
end
