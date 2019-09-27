defmodule OkComputer.NonNil do
  @moduledoc """
  Pipe operators and macros for non-nil values.
  """
  @doc """
  Ok operator that pipes non-`nil` values.

  If the input is non-`nil` then it will be piped to the `right` function, otherwise it will be returned.

  ## Examples

      iex> import OkComputer.NonNil
      iex> :a ~> to_string
      "a"
      iex> nil ~> to_string
      nil
  """
  defmacro left ~> right do
    quote do
      if unquote(left) != nil do
        unquote(Macro.pipe(left, right, 0))
      else
        unquote(left)
      end
    end
  end

  @doc """
  Error operator that pipes `nil` values.

  If the input is `nil` then it will be piped to the `right` function, otherwise it will be returned.

  ## Examples

      iex> import OkComputer.NonNil
      iex> :a ~>> to_string
      :a
      iex> nil ~>> to_string
      ""
  """
  defmacro left ~>> right do
    quote do
      if unquote(left) == nil do
        unquote(Macro.pipe(left, right, 0))
      else
        unquote(left)
      end
    end
  end

  defmacro case_ok(value, do: [{:->, _, [[left], right]}]) do
    quote do
      case unquote(value) do
        nil -> nil
        unquote(left) -> unquote(right)
      end
    end
  end

  defmacro case_ok(value, do: [{:->, _, [[left], right]} | tail]) do
    quote do
      value = unquote(value)

      case value do
        nil -> nil
        unquote(left) -> unquote(right)
        _ -> case_ok(value, do: unquote(tail))
      end
    end
  end
end
