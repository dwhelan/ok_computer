defmodule OkComputer.Pipe do
  @moduledoc """
  """

  @doc """
  Inserts an operator function that calls a monadic function.

  The operator function generated for `:bind` and `Result` would be sort of like:
  ```
    def bind(left, right) do
      Result.bind(left, fn _ -> left |> right)
    end
  ```

  Effectively, it is bridge between binary operators and monads.
  """
  @spec pipe(atom, module) :: Macro.t()
  defmacro pipe(name, module) do
    quote do
      @name unquote(name)
      @module unquote(module)

      def unquote(name)(left, right) do
        quote do
          unquote(@module).unquote(@name)(unquote(left), fn left -> left |> unquote(right) end)
        end
      end
    end
  end
end
