defmodule OkComputer do
  @callback atoms() :: [Atom.t]
end

defmodule Monad do
  @behaviour OkComputer
  @callback new(term) :: Tuple.t

  def new _, [] do
    {:error, :no_monads_provided}
  end

  def new {a, v} = x, ms  do
    monad_for(a, ms).new x
  end

  def new v, ms do
    hd(ms).new v
  end

  defp monad_for a, ms do
    case ms |> List.wrap |> Enum.find(& a in &1.atoms) do
      nil -> hd(ms)
      m   -> m
    end
  end
end

defmodule MonadTest.A do
  @behaviour Monad

  def atoms(), do: [:a]

  def new({:a, v}), do: {:a, "A #{inspect v}"}
  def new(v),       do: {:a, "A #{inspect v}"}
end

defmodule MonadTest.AB do
  @behaviour Monad

  def atoms(), do: [:a, :b]

  def new({:a, v}), do: {:a, "AB #{inspect v}"}
  def new({:b, v}), do: {:b, "AB #{inspect v}"}
  def new(v),       do: {:b, "AB #{inspect v}"}
end

defmodule MonadTest do
  use ExUnit.Case
  alias MonadTest.{A, AB}

  import Monad

  describe "new should" do
    test "support a single monad" do
      assert new({:a, :v}, A) == {:a, "A :v"}
    end

    test "support a list with a single monad" do
      assert new({:a, :v}, [A]) == {:a, "A :v"}
    end

    test "map tuples to monads via its atom" do
      assert new({:a, :v}, [A, AB]) == {:a, "A :v" }
      assert new({:b, :v}, [A, AB]) == {:b, "AB :v" }
      assert new({:c, :v}, [A, AB]) == {:a, "A {:c, :v}"}
    end

    test "map bare values to the first monad" do
      assert new(:v, [A, AB]) == {:a, "A :v"}
    end

    test "return an error tuple if no monads provided" do
      assert new({:a, :v}, []) == {:error, :no_monads_provided}
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

