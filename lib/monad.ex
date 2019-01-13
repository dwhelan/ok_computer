defmodule Monad do
  @behaviour OkComputer
  @callback return(term) :: Tuple.t

  defmacro __using__(modules) when is_list(modules) do
    build_monad modules
  end

  defmacro __using__ module do
    build_monad [module]
  end

  defp build_monad(modules) do
    modules
    |> ensure_modules_are_monads
    |> def_new_for_modules
    |> def_new_for_plain_value(hd modules)
  end

  defp ensure_modules_are_monads [] do
    raise ArgumentError, """
    "use Monad" expects to be passed a module, or list of modules, with monad behaviour. For example:


      defmodule MyModule do
        use Monad, Maybe
      end
    """
  end

  defp ensure_modules_are_monads modules do
    modules
  end

  defp def_new_for_modules modules do
    Enum.map modules, &def_new_for_module/1
  end

  defp def_new_for_module module do
    quote do
      unquote(module).atoms |> Enum.map fn atom ->
        @atom atom
        def return {@atom, value} do
          unquote(module).return {@atom, value}
        end
      end
    end
  end

  defp def_new_for_plain_value quoted, module do
    quoted ++ [quote do
      def return value do
        unquote(module).return value
      end
    end]
  end
end