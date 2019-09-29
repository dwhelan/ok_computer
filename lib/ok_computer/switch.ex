defmodule OkComputer.Switch do
  defmacro monadic_switch(ok_monad, error_monad) do
    quote do
      import OkComputer.Pipe
      import OkComputer.Case

      def ok_monad(), do: unquote(ok_monad)
      def error_monad(), do: unquote(error_monad)

      monadic_pipe
      monadic_case
    end
  end
end
