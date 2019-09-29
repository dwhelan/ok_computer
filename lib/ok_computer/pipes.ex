defmodule OkComputer.Pipes do
  @moduledoc """
  Pipe operators for ok and error values.

  The `~>` operator will pipe ok values and return error values.

  ## Examples

    `NonNil` treats `nil` values as errors and anything else as ok.

      iex> import OkComputer.NonNil
      ...>
      iex> nil ~> to_string
      nil
      ...>
      iex> :anything_else ~> to_string
      "a"
      ...>

  The `~>>` operator will pipe error values and return ok values.

  ## Examples

      iex> :a ~>> to_string
      :a
      ...>
      iex> nil ~>> to_string
      ""
  """
  defmacro defpipes() do
    quote do
      defmacro left ~> right do
        quote do
          unquote(left)
          |> ok_monad().bind(fn value ->
            unquote(Macro.pipe(left, right, 0))
          end)
        end
      end

      defmacro left ~>> right do
        quote do
          unquote(left)
          |> error_monad().bind(fn value ->
            unquote(Macro.pipe(left, right, 0))
          end)
        end
      end
    end
  end
end
