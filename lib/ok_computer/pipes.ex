defmodule OkComputer.Pipe do
  @moduledoc """
  Pipe operators for ok and error values.

  The ok operator, `~>`, will pipe ok values and return error values.

  The error operator, `~>>`, will pipe error values and return ok values.
  """
  defmacro monadic_pipe() do
    quote do
      defmacro left ~> right do
        quote do
          unquote(left)
          |> ok_monad().bind(fn _ -> unquote(Macro.pipe(left, right, 0)) end)
        end
      end

      defmacro left ~>> right do
        quote do
          unquote(left)
          |> error_monad().bind(fn _ -> unquote(Macro.pipe(left, right, 0)) end)
        end
      end
    end
  end
end
