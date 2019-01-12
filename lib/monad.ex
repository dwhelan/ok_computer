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
    |> def_new_for_modules
    |> def_new_for_plain_value(hd modules)
  end

  defp def_new_for_modules modules do
    Enum.map modules, &def_new_for_module/1
  end

  defp def_new_for_module module do
    quote do
      unquote(module).atoms |> Enum.map fn atom ->
        @atom atom
        def new {@atom, value} do
          unquote(module).new {@atom, value}
        end
      end
    end
  end

  defp def_new_for_plain_value quoted, module do
    quoted ++ [quote do
      def new value do
        unquote(module).new value
      end
    end]
  end
end
