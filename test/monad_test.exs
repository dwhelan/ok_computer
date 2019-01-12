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
    IO.inspect code = modules |> build_news
    code |> Macro.to_string |> IO.inspect
    code
  end

  defp build_news(modules) when is_list(modules) do
    modules |> Enum.map fn module -> def_new module end
  end

  defp def_new module do
      quote do
        unquote(module).atoms |> Enum.map fn atom ->
          def new {atom, value} do
            unquote(module).new value
          end
        end
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
  use Monad, [A]

  describe "new should" do
    test "support a single monad" do
      assert new({:a, :v}, A) == {:a, "A :v"}
      assert new({:a, :v}) == {:a, "A :v"}
    end

    test "support a list with a single monad" do
      assert new({:a, :v}) == {:a, "A :v"}
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

