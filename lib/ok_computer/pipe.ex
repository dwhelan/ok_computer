defmodule OkComputer.Pipe do
  @moduledoc """
  Builds monadic pipes.

  Pipe operators are limited to binary operators that associate left to right:
  - `.`, `*`, `/`, `+`, `-`, `^^^`, `in`, `not in`,
  - `|>`, `<<<`, `>>>`, `<<~`, `~>>`, `<~`, `~>`, `<->`, `<|>`
  - `<`, `>`, `<=`, `>=`, `==`, `!=`, `=~`, `===`, `!==`, `&&`, `&&&`, `and`, `||`, `|||`, `or`, ``
  - `<-`, `\\`

  Suggestion:
  ~> ok with fmap
  ~>> ok with bind
  <~ handle error with fmap
  <<~ handle error with bind

  >>> ok with third option
  <<< handle error third option

  >>>
  """
  @doc """
  Creates ast for `monad.bind(m, fn a -> a |> f)`.
  """
  def monadic(lhs, rhs, module, function) do
    quote do
      unquote(module).unquote(function)(unquote(lhs), fn a -> a |> unquote(rhs) end)
    end
  end

  @spec build(module, keyword(atom)) :: Macro.t()
  defmacro build(module, pipes) do
    pipes
    |> Enum.map(fn {function, pipe} -> _pipe(module, function, pipe) end)
  end

  @spec build(module, atom, atom) :: Macro.t()
  defmacro build(module, function, pipe) do
    _pipe(module, function, pipe)
  end

  defp _pipe(module, function, pipe) do
    case pipe do
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
