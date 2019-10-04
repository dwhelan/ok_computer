defmodule OkComputer.Operation.Pipe do
  @moduledoc """
  Pipe operators for ok and error values.

  The ok operator, `~>`, will pipe ok values and return error values.

  The error operator, `~>>`, will pipe error values and return ok values.
  """
  def pipe(left, right, monad) do
    quote do
      unquote(monad).bind(unquote(left), fn _ -> unquote(Macro.pipe(left, right, 0)) end)
    end
  end

  @spec pipe() :: Macro.t()
  defmacro pipe() do
    quote do
      defmacro left ~> right do pipe(left, right, monad_ok()) end
      defmacro left ~>> right do pipe(left, right, monad_error()) end
    end
  end

  defmacro build(name, monad, operator) do
    case operator do
      :~> -> quote do defmacro left ~> right do pipe(left, right, unquote(monad)) end end
      :~>> -> quote do defmacro left ~>> right do pipe(left, right, unquote(monad)) end end
    end
    quote do
      defmacro left ~> right do pipe(left, right, monad_ok()) end
      defmacro left ~>> right do pipe(left, right, monad_error()) end
    end
  end
end
