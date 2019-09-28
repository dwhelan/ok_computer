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

  defmacro case_ok(value, do: do_clauses) do
    quote do
      value = unquote(value)

      case value do
        nil -> nil
        _ -> case unquote(value), do: unquote(do_clauses)
      end
    end
  end
end
