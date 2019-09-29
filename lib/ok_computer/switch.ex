defmodule OkComputer.Switch do
  @doc "The ok monad to use"
  @callback ok_monad() :: module

  @doc "The error monad to use"
  @callback error_monad() :: module

  defmacro monadic_switch(ok_monad, error_monad) do
    quote do
      alias OkComputer.{Pipe, Case, Switch}
      import Pipe
      import Case

      @behaviour Switch

      @impl Switch
      def ok_monad(), do: unquote(ok_monad)

      @impl Switch
      def error_monad(), do: unquote(error_monad)

      monadic_pipe
      monadic_case
    end
  end
end
