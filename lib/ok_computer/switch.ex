defmodule OkComputer.Switch do
  @moduledoc """
  Pipes and macros for handling ok and error values.

  A switch provides pipe operators and macros for handling
  both ok and error values.
  """

  @doc """
  Creates a switch using an ok monad and an error monad.
  """
  @spec switch(module, module) :: Macro.t()
  defmacro switch(ok_monad, error_monad) do
    quote do
      alias OkComputer.{Pipe, Case, Switch}

      import Pipe
      import Case

      def ok_monad(), do: unquote(ok_monad)
      def error_monad(), do: unquote(error_monad)

      pipe()
      case_()
    end
  end
end
