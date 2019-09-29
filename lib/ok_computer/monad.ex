defmodule OkComputer.Monad do
  @moduledoc """
  Describes monadic behaviour.
  """
  @type t :: any

  @doc "return"
  @callback return(any) :: t

  @doc "bind"
  @callback bind(t, (any -> t)) :: t

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
