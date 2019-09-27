defmodule OkComputer.Truthy do
  @moduledoc """
  Pipe operators and macros for truthy values.
  """
  @doc """
  Ok operator that pipes truthy values (not `nil`,  not `false`).

  If the input is truthy (not `nil`, not `false`) then it will be piped to the `right` function, otherwise it will be returned.

  ## Examples

      iex> import OkComputer.Truthy
      iex> :a ~> to_string
      "a"
      iex> false ~> to_string
      false
      iex> nil ~> to_string
      nil
  """
  defmacro left ~> right do
    quote do
      if unquote(left) do
        unquote(Macro.pipe(left, right, 0))
      else
        unquote(left)
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
      if unquote(left) do
        unquote(left)
      else
        unquote(Macro.pipe(left, right, 0))
      end
    end
  end

  @doc """
  Applies truthy values to a case expression.

  If `value` is truthy (not `nil`, not `false`) it will be evaluated using `Kernel.SpecialForms.case/2`,
  otherwise `value` will be returned.

  ## Examples

  ```
  case_ok value do
    1 -> "one"
    2 -> "two"
    3 -> "three"
  end
  ```
  In the example above if `value` is `nil`, or `false` it will be returned.
  This may be convenient as you don't need to create clauses for `nil` or `false` values.
  """
  defmacro case_ok(value, do: clauses) do
    quote do
      value = unquote(value)

      case value do
        nil -> nil
        false -> false
        _ -> case unquote(value), do: unquote(clauses)
      end
    end
  end
end
