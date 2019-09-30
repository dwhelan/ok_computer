defmodule OkComputer.Switch do
  @moduledoc """
  Pipes and macros for handling ok and error values.

  A switch provides pipe operators and macros for handling
  both ok and error values.
  """
  @doc """
  The ok monad to use

  Any
  ## Examples

      iex> 
      
  """
  @callback ok_monad() :: module

  @doc "The error monad to use"
  @callback error_monad() :: module

  @spec monadic_switch(module, module) :: Macro.t()
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

      pipe()
      monadic_case()
    end
  end
end
