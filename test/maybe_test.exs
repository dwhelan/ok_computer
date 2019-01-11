defmodule OkComputer.Maybe do
  def wrap(:nil), do: :nothing
end

defmodule OkComputer.MaybeTest do
  use ExUnit.Case

  alias OkComputer.Maybe

  describe "wrap" do
    test "nil -> :nothing" do
      assert Maybe.wrap(nil) == :nothing
    end
  end
end
