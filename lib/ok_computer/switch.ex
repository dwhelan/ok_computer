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
  defmacro switch(monad_ok, monad_error) do
    quote do
      alias OkComputer.Operation.{Pipe, Case}

      import Pipe
      import Case

      def monad_ok(), do: unquote(monad_ok)
      def monad_error(), do: unquote(monad_error)

      Pipe.build(:ok, unquote(monad_ok), :~>)
      Pipe.build(:error, unquote(monad_error), :~>>)
      Case.build(:ok, unquote(monad_ok))
      Case.build(:error, unquote(monad_error))
    end
  end
end
