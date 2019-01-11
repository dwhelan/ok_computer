defmodule OkComputer.Maybe do
  def wrap(:nil), do: :nothing
  def wrap(maybe), do: maybe
end

defmodule OkComputer.MaybeTest do
  use ExUnit.Case

  alias OkComputer.Maybe

  describe "wrap" do
    test "nil -> :nothing" do
      assert Maybe.wrap(nil) == :nothing
    end

    test "{:just, v} -> {:just, v}" do
      assert Maybe.wrap({:just, "v"}) == {:just, "v"}
    end
  end
end
