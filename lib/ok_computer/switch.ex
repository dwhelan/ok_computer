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
  defmacro switch(monad_ok, error_monad) do
    quote do
      alias OkComputer.{Pipe, Case}

      import Pipe
      import Case

      def monad_ok(), do: unquote(monad_ok)
      def error_monad(), do: unquote(error_monad)

      pipe()
      case_(:ok, unquote(monad_ok))
      case_(:error, unquote(error_monad))
    end
  end
end
