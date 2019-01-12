defmodule Monad do
  @behaviour OkComputer
  @callback new(term) :: Tuple.t

  def new _, [] do
    {:error, :no_monads_provided}
  end

  def new m = {atom, _}, modules do
    module_for(atom, modules).new m
  end

  def new(m, modules) when is_list(modules) do
    hd(modules).new m
  end

  defp module_for atom, modules do
    case modules |> List.wrap |> Enum.find(fn module -> atom in module.atoms end) do
      nil    -> modules |> List.first
      module -> module
    end
  end

  defmacro __using__ modules do
    modules
    |> Enum.map(&def_new/1)
    |> def_default_new(modules)
  end

  defp def_new(module) do
    quote do
      unquote(module).atoms
      |> Enum.map fn atom ->
        @atom atom
        def new {@atom, value} do
          unquote(module).new value
        end
      end
    end
  end

  defp def_default_new quoted, modules do
    quoted ++ [quote do
      def new value do
        unquote(hd modules).new value
      end
    end]
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
  use Monad, [A, AB]

  describe "should create 'new' methods that" do
    test "map tuples to monads via atoms" do
      assert new({:a, :v}) == {:a, "A :v" }
      assert new({:b, :v}) == {:b, "AB :v" }
    end

    test "map bare values to the first monad" do
      assert new(:_) == {:a, "A :_"}
    end

    test "return an error tuple if no monads provided" do
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

