defmodule OkComputer.Pipe do
  @moduledoc """
  Builds monadic pipes.

  Pipe operators are limited to binary operators that associate left to right:
  - `.`, `*`, `/`, `+`, `-`, `^^^`, `in`, `not in`,
  - `|>`, `<<<`, `>>>`, `<<~`, `~>>`, `<~`, `~>`, `<->`, `<|>`
  - `<`, `>`, `<=`, `>=`, `==`, `!=`, `=~`, `===`, `!==`, `&&`, `&&&`, `and`, `||`, `|||`, `or`, ``
  - `<-`, `\\`
  """

  @type t :: any

  @doc "bind"
  @callback bind(t, (any -> t)) :: t

  @doc "fmap"
  @callback fmap(t, (any -> any)) :: t

  defmacro __using__(_) do
    quote do
      alias OkComputer.Pipe
      import Pipe

      @behaviour Pipe

      @impl Pipe
      def fmap(a, f), do: bind(a, f)

      defoverridable fmap: 2
    end
  end

  @doc """
  Creates ast for `monad.bind(m, fn a -> a |> f)`.
  """
  def monadic(lhs, rhs, module, function) do
    quote do
      unquote(module).unquote(function)(unquote(lhs), fn a -> a |> unquote(rhs) end)
    end
  end

  @spec pipe(module, keyword(atom)) :: Macro.t()
  defmacro pipe(module, operators \\ [fmap: :~>, bind: :~>>])

  defmacro pipe(_module, []) do
    raise ArgumentError, "must provide at least one function to pipe"
  end

  defmacro pipe(module, operators) do
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

  defmacro foo(pipes) do
    pipe_macros =
      pipes
      |> List.wrap()
      |> Enum.map(fn foo -> pipe_macro(foo, __CALLER__) end)
      |> Enum.join()

    Code.compile_string("""
      defmodule #{__CALLER__.module}.Pipes do
        #{pipe_macros}
      end
    """)

    quote do
      import __MODULE__.Pipes
    end
  end

  defp pipe_macro({:__aliases__, _, _} = alias, env) do
    pipe_macro(:~>, alias, :fmap, env) <> pipe_macro(:~>>, alias, :bind, env)
  end

  defp pipe_macro({:~>, alias}, env) do
    pipe_macro(:~>, alias, :fmap, env)
  end

  defp pipe_macro({:~>>, alias}, env) do
    pipe_macro(:~>>, alias, :bind, env)
  end

  defp pipe_macro(operator, alias, function, env) do
    """
      defmacro lhs #{operator} rhs do
        quote do
          #{Macro.expand(alias, env)}.#{function}(unquote(lhs), fn a -> a |> unquote(rhs) end)
         end
      end
    """
  end
end
