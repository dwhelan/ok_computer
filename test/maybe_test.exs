defprotocol OkComputer.Monad do
  def wrap(v)
end

defmodule OkComputer.Maybe do
  def wrap(:nil),       do: :nothing
  def wrap(:nothing),   do: :nothing
  def wrap({:just, v}), do: {:just, v}
  def wrap(v),          do: {:just, v}
end

defimpl OkComputer.Monad, for: Tuple do
  defdelegate wrap(v), to: OkComputer.MayBe
end

#defmodule Macros do
#  defmacro __using__ opts \\ [] do
#    quote do
#      opts = unquote(opts)
#      IO.inspect opts[]
#      test "foo" do
#      end
#    end
#  end
#end

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
