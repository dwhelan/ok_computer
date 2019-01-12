defmodule MonadTest.A do
  @behaviour Monad
  def atoms(), do: [:a]

  def new({:a, v}), do: {:a, "A #{inspect v}"}
  def new(v),       do: {:a, "A #{inspect v}"}
end

defmodule MonadTest.B do
  @behaviour Monad

  def atoms(), do: [:b]

  def new({:b, v}), do: {:b, "B #{inspect v}"}
  def new(v),       do: {:b, "B #{inspect v}"}
end

defmodule MonadTest do
  use ExUnit.Case
  alias MonadTest.{A, B}

  import Monad
  use Monad, [A, B]

  describe "should create 'new' methods that" do
    test "map tuples to modules via atoms" do
      assert new({:a, :v}) == {:a, "A :v" }
      assert new({:b, :v}) == {:b, "B :v" }
    end

    test "map bare values to the first module" do
      assert new(:_) == {:a, "A :_"}
    end

    test "return an error tuple if no modules provided" do
      assert new({:a, :v}, []) == {:error, :no_monads_provided}
    end
  end
end

#defmodule Macros do
#  defmacro __using__ opts \\ [] do
#    quote do
#      opts = unquote(opts)
#      IO.inspect opts[]
#      test "with_atoms" do
#      end
#    end
#  end
#end

