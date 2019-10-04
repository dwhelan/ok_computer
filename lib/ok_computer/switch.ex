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
    alias OkComputer.Operation.{Pipe, Case}
    operations = [Case]
    monads = [ok: {monad_ok, :~>}, error: {monad_error, :~>>}]

    [
      for operation <- operations, {name, monad} <- monads, into: [] do
        build_operation(operation, {name, monad})
      end,
      quote do
        alias OkComputer.Operation.{Pipe, Case}

        import Pipe
        Pipe.build(:~>, unquote(monad_ok))
        Pipe.build(:~>>, unquote(monad_error))
      end
    ]
  end

  def build_operation(operation, {name, {monad, _pipe}}) do
    quote do
      require unquote(operation)
      unquote(operation).build(unquote(name), unquote(monad))
    end
  end
end
