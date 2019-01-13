defmodule Maybe do
  @behaviour Monad

  def atoms(), do: [:just, :nothing]

  def return(:nil),       do: :nothing
  def return(:nothing),   do: :nothing
  def return({:just, v}), do: {:just, v}
  def return(v),          do: {:just, v}
end

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

    test "v -> {:just, v}" do
      assert return("v") == {:just, "v"}
    end

    test "{:just, v} -> {:just, v}" do
      assert return({:just, "v"}) == {:just, "v"}
    end
  end
end
