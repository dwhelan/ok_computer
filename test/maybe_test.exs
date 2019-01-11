defmodule OkComputer do
  @callback atoms() :: [Atom.t]
end

defmodule Monad do
  @behaviour OkComputer
  @callback new(term) :: Tuple.t

  def new(tuple, ms) when is_tuple(tuple) do
    m = ms |> List.wrap |> Enum.find(& elem(tuple, 0) in &1.atoms)
    m.new tuple
  end

  def new(v, ms) do
    hd(ms).new(v)
  end
end

defmodule MonadTest.AB do
  @behaviour Monad

  def atoms(), do: [:a, :b]

  def new({:a, v}), do: {:a, "AB #{v}"}
  def new({:b, v}), do: {:b, "AB #{v}"}
  def new(v),       do: {:a, "AB #{v}"}
end

defmodule MonadTest.ABC do
  @behaviour Monad

  def atoms(), do: [:a, :b, :c]

  def new({:a, v}), do: {:a, "ABC #{v}"}
  def new({:v, v}), do: {:b, "ABC #{v}"}
  def new({:c, v}), do: {:c, "ABC #{v}"}
  def new(v),       do: {:c, "ABC #{v}"}
end

defmodule MonadTest do
  use ExUnit.Case
  alias MonadTest.{AB, ABC}

  describe "new should" do
    test "support a single monad" do
      assert Monad.new({:a, 'v'}, AB) == {:a, "AB v"}
    end

    test "support a list with a single monad" do
      assert Monad.new({:a, 'v'}, [AB]) == {:a, "AB v"}
    end

    test "map tuples to monads via atom" do
      assert Monad.new({:a, 'v'}, [AB, ABC]) == {:a, "AB v" }
      assert Monad.new({:b, 'v'}, [AB, ABC]) == {:b, "AB v" }
      assert Monad.new({:c, 'v'}, [AB, ABC]) == {:c, "ABC v"}
    end

    test "map bare values to the first monad" do
      assert Monad.new('v', [AB, ABC]) == {:a, "AB v"}
    end
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
      assert Maybe.new('v') == {:just, 'v'}
    end

    test "{:just, v} -> {:just, v}" do
      assert Maybe.new({:just, 'v'}) == {:just, 'v'}
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

