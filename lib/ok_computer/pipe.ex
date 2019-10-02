defmodule OkComputer.Pipe do
  @moduledoc """
  Pipe operators for ok and error values.

  The ok operator, `~>`, will pipe ok values and return error values.

  The error operator, `~>>`, will pipe error values and return ok values.
  """

  @spec pipe() :: Macro.t()
  defmacro pipe() do
    quote do
      @spec Macro.t() ~> Macro.t() :: Macro.t()
      defmacro left ~> right do
        quote do
          unquote(left)
          |> monad_ok().bind(fn _ -> unquote(Macro.pipe(left, right, 0)) end)
        end
      end

      @spec Macro.t() ~>> Macro.t() :: Macro.t()
      defmacro left ~>> right do
        quote do
          unquote(left)
          |> monad_error().bind(fn _ -> unquote(Macro.pipe(left, right, 0)) end)
        end
      end
    end
  end
end
