defmodule Monad do
  @type monad :: any
  @type t :: monad

  @callback return(any) :: monad
  @callback bind(t, (any -> monad)) :: monad

  defmacro __using__(modules) when is_list(modules) do
    build_monad modules
  end

  defmacro __using__ module do
    build_monad [module]
  end

  defp build_monad(modules) do
    ensure_modules_are_monads modules
    delegate_return hd modules
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

  defp delegate_return module do
    quote do
      @behaviour Monad

      defdelegate return(value),  to: unquote(module)
      defdelegate bind(value, f), to: unquote(module)
    end
  end
end
