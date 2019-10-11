defmodule OkComputer.Switch.ValueNilTest do
  alias OkComputer.Switch.ValueNil

  use ExUnit.Case
  import Monad.Laws
  import ValueNil

  doctest ValueNil

  #  test "~>" do
  #    assert :a ~> to_string() == "a"
  #    assert nil ~> to_string() == nil
  #  end
  #
  #  test "~>>" do
  #    assert :a ~>> to_string() == "a"
  #    assert nil ~>> to_string() == nil
  #  end
  #
  #  test "<~" do
  #    assert :a <~ to_string() == :a
  #    assert nil <~ to_string() == ""
  #  end
  #
  #  test "<<~" do
  #    assert :a <~ to_string() == :a
  #    assert nil <~ to_string() == ""
  #  end
end
