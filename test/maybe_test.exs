defmodule OkComputer.Maybe do
  def wrap(:nil),       do: :nothing
  def wrap(:nothing),   do: :nothing
  def wrap({:just, v}), do: {:just, v}
  def wrap(v),          do: {:just, v}
end

defmodule OkComputer.MaybeTest do
  use ExUnit.Case

  alias OkComputer.Maybe

  describe "wrap" do
    test "nil -> :nothing" do
      assert Maybe.wrap(nil) == :nothing
    end

    test ":nothing -> :nothing" do
      assert Maybe.wrap(:nothing) == :nothing
    end

    test "v -> {:just, v}" do
      assert Maybe.wrap("v") == {:just, "v"}
    end

    test "{:just, v} -> {:just, v}" do
      assert Maybe.wrap({:just, "v"}) == {:just, "v"}
    end
  end
end
