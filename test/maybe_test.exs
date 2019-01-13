defmodule MaybeTest do
  use ExUnit.Case

  import Maybe

  describe "return" do
    test "nil -> :nothing" do
      assert return(nil) == :nothing
    end

    test ":nothing -> :nothing" do
      assert return(:nothing) == :nothing
    end

    test "{:just, v} -> {:just, v}" do
      assert return({:just, "v"}) == {:just, "v"}
    end

    test "v -> {:just, v}" do
      assert return("v") == {:just, "v"}
    end
  end

  describe "bind should" do
    test "apply function if a just is provided" do
      assert bind({:just, 1}, fn x -> x + 2 end) == 3
    end

    test "bypass function if a nothing is provided" do
      assert bind(:nothing, fn x -> x + 2 end) == :nothing
    end
  end
end
