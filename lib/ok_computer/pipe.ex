defmodule OkComputer.Pipe do
  @moduledoc """
  Builds monadic pipes.

  Pipe operators are limited to binary operators that associate left to right:
  - `.`, `*`, `/`, `+`, `-`, `^^^`, `in`, `not in`,
  - `|>`, `<<<`, `>>>`, `<<~`, `~>>`, `<~`, `~>`, `<->`, `<|>`
  - `<`, `>`, `<=`, `>=`, `==`, `!=`, `=~`, `===`, `!==`, `&&`, `&&&`, `and`, `||`, `|||`, `or`, ``
  - `<-`, `\\`
  """


  @doc """
  Creates ast for `monad.bind(m, fn a -> a |> f)`.
  """
  def monadic(lhs, rhs, module, function) do
    quote do
      unquote(module).unquote(function)(unquote(lhs), fn a -> a |> unquote(rhs) end)
    end
  end

  @spec pipe(module, keyword(atom)) :: Macro.t()
  defmacro pipe(module, []) do
    raise ArgumentError, "must provide at least one function to pipe"
  end

  defmacro pipe(module, operators \\ [fmap: :~>, bind: :~>>]) do
    operators
    |> Enum.map(fn {function, operator} -> _pipe(module, function, operator) end)
  end

  defp _pipe(module, function, operator) do
    case operator do
      :~> ->
        quote do
          defmacro lhs ~> rhs do
            OkComputer.Pipe.monadic(lhs, rhs, unquote(module), unquote(function))
          end
        end

      :~>> ->
        quote do
          defmacro lhs ~>> rhs do
            OkComputer.Pipe.monadic(lhs, rhs, unquote(module), unquote(function))
          end
        end

      :<~ ->
        quote do
          defmacro lhs <~ rhs do
            OkComputer.Pipe.monadic(lhs, rhs, unquote(module), unquote(function))
          end
        end

      :<<~ ->
        quote do
          defmacro lhs <<~ rhs do
            OkComputer.Pipe.monadic(lhs, rhs, unquote(module), unquote(function))
          end
        end
    end
  end
end
