defmodule OkComputer.Pipe do
  @moduledoc """
  """

  @doc """

  Given a `module`, `function`and quoted `left` and quoted `right` will return the quoted
  equivalent of:
  ```
    module.function(left, fn left -> left |> right)
  ```
  This allows `module.function/2` to decide whether to pipe to `right` or short-circuit
  by returning its `left` input.

  The `left` can be any quoted value.
  The `right` can be anything quoted that you can pipe into with `|>`.
  """
  @spec pipe(module, atom, Macro.t(), Macro.t()) :: Macro.t()
  def pipe(module, function_name, left, right) do
    quote do
      unquote(module).unquote(function_name).(unquote(left), fn left -> left |> unquote(right) end)
    end
  end

  defmacro pipe(module, function_name) do
    quote do
      @module unquote(module)
      @function_name unquote(function_name)

      def unquote(function_name)(left, right) do
        quote do
          unquote(@module).unquote(@function_name)(unquote(left), fn left -> left |> unquote(right) end)
        end
      end
    end
  end
end
