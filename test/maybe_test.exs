defmodule OkComputer do
  @callback atoms() :: [Atom.t]
end

defmodule Monad do
  @behaviour OkComputer
  @callback new(term) :: Tuple.t

  def new(tuple, ms) when is_tuple(tuple) do
    m = ms |> List.wrap |> Enum.find(& elem(tuple, 0) in &1.atoms) || hd(ms)
    m.new tuple
  end

  def new(v, ms) do
    hd(ms).new(v)
  end
end

defmodule MonadTest.AB do
  @behaviour Monad

  def atoms(), do: [:a, :b]

  def new({:a, v}), do: {:a, v}
  def new({:b, v}), do: {:b, v}
  def new(v),       do: {:a, v}
end

defmodule MonadTest.CD do
  @behaviour Monad

  def atoms(), do: [:c, :d]

  def new({:c, v}), do: {:c, v}
  def new({:d, v}), do: {:d, v}
  def new(v),       do: {:c, v}
end

defmodule MonadTest do
  use ExUnit.Case
  alias MonadTest.{AB, CD}

  test "new with a single monad should call its new/1" do
    assert Monad.new({:a, 'v'}, AB) == {:a, 'v'}
  end

  test "new with a single monad list" do
    assert Monad.new({:a, 'v'}, [AB]) == {:a, 'v'}
  end

  test "new should call the corresponding monad" do
    assert Monad.new({:a, 'v'}, [AB, CD]) == {:a, 'v'}
    assert Monad.new({:c, 'v'}, [AB, CD]) == {:c, 'v'}
  end

  test "new should send values to the first moand" do
    assert Monad.new('v', [AB, CD]) == {:a, 'v'}
  end
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

