defmodule OkComputer.Pipes do
  @moduledoc """
  Pipe operators.
  """

  @doc """
  An pipe operator that only pipes ok values.

  ## Examples

      iex> import OkComputer.Truthy
      iex> nil ~> to_string
      nil
      iex> false ~> to_string
      false
      iex> :anything_else ~> to_string
      "a"
  """
  defmacro left ~> right do
    quote do
      value = unquote(left)

      case ok?(value) do
        true -> unquote(Macro.pipe(left, right, 0))
        false -> value
      end
    end
  end

  @doc """
  Error operator that pipes falsey values (`nil` or `false`).

  If the input is falsey (`nil` or `false`) then it will be piped to the `right` function, otherwise it will be returned.

  ## Examples

      iex> import OkComputer.Truthy
      iex> :a ~>> to_string
      :a
      iex> false ~>> to_string
      "false"
      iex> nil ~>> to_string
      ""
  """
  defmacro left ~>> right do
    quote do
      value = unquote(left)

      case error?(value) do
        true -> unquote(Macro.pipe(left, right, 0))
        false -> value
      end
    end
  end
end