defmodule Maybe do
  @behaviour Monad

  def atoms(), do: [:just, :nothing]

  def new(:nil),       do: :nothing
  def new(:nothing),   do: :nothing
  def new({:just, v}), do: {:just, v}
  def new(v),          do: {:just, v}
end

defmodule MaybeTest do
  use ExUnit.Case

  import Maybe

  describe "new" do
    test "nil -> :nothing" do
      assert new(nil) == :nothing
    end

    test ":nothing -> :nothing" do
      assert new(:nothing) == :nothing
    end

    test "v -> {:just, v}" do
      assert new("v") == {:just, "v"}
    end

    test "{:just, v} -> {:just, v}" do
      assert new({:just, "v"}) == {:just, "v"}
    end
  end
end
