defmodule Maybe do
  @behaviour Monad

  def atoms(), do: [:just, :nothing]

  def return(:nil),       do: :nothing
  def return(:nothing),   do: :nothing
  def return({:just, v}), do: {:just, v}
  def return(v),          do: {:just, v}

  def bind({:just, v}, f) when is_function(f), do: f.(v)
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
  end
end
