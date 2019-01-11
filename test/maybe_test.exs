defmodule OkComputer do
  @callback atoms() :: [Atom.t]
end

defmodule Monad do
  @behaviour OkComputer
  @callback new(term) :: Tuple.t
end

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

  alias Maybe

  describe "new" do
    test "nil -> :nothing" do
      assert Maybe.new(nil) == :nothing
    end

    test ":nothing -> :nothing" do
      assert Maybe.new(:nothing) == :nothing
    end

    test "v -> {:just, v}" do
      assert Maybe.new("v") == {:just, "v"}
    end

    test "{:just, v} -> {:just, v}" do
      assert Maybe.new({:just, "v"}) == {:just, "v"}
    end
  end
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

