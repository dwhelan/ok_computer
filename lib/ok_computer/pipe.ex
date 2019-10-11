defmodule OkComputer.Pipe do
  @moduledoc """
  Builds monadic pipes.

  """

  @type t :: term

  @doc "bind"
  @callback bind(t, (term -> t)) :: t

  @doc "fmap"
  @callback fmap(t, (term -> term)) :: t

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

  defmacro pipe([]) do
    raise ArgumentError, "must provide at least one pipe"
  end

  defmacro pipe({:__aliases__, _, _} = right) do
    create_pipe_module(
      [right_pipe_macros(right, __CALLER__)],
      __CALLER__
    )
  end

  defmacro pipe({:__aliases__, _, _} = left, {:__aliases__, _, _} = right) do
    create_pipe_module(
      [left_pipe_macros(left, __CALLER__), right_pipe_macros(right, __CALLER__)],
      __CALLER__
    )
  end

  defp create_pipe_module(pipe_macros, env) do
    Code.compile_string("""
      defmodule #{env.module}.Pipes do
        #{Enum.join(pipe_macros)}
      end
    """)

    quote do
      import __MODULE__.Pipes
    end
  end

  defp left_pipe_macros(alias, env) do
    pipe_macro(:<~, alias, :fmap, env) <> pipe_macro(:<<~, alias, :bind, env)
  end

  defp right_pipe_macros(alias, env) do
    pipe_macro(:~>, alias, :fmap, env) <> pipe_macro(:~>>, alias, :bind, env)
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
