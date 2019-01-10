defmodule OkComputerTest do
  use ExUnit.Case
  doctest OkComputer

  test "greets the world" do
    assert OkComputer.hello() == :world
  end
end
