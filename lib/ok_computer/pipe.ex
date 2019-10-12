defmodule OkComputer.Pipe do
  @moduledoc """
  Builds monadic pipes.
  """

  @type t :: term

  @doc "bind"
  @callback bind(t, (term -> t)) :: t

  @doc "fmap"
  @callback fmap(t, (term -> term)) :: t

  import OkComputer.Operator

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

  # opionated
  defmacro pipe({:__aliases__, _, _} = right) do
    import_pipe_module(
      [
        pipe_source(:~>, right, :fmap, __CALLER__),
        pipe_source(:~>>, right, :bind, __CALLER__)
      ],
      __CALLER__
    )
  end

  # opionated
  defmacro pipe({:__aliases__, _, _} = left, {:__aliases__, _, _} = right) do
    import_pipe_module(
      [
        pipe_source(:~>, right, :fmap, __CALLER__),
        pipe_source(:~>>, right, :bind, __CALLER__),
        pipe_source(:<~, left, :fmap, __CALLER__),
        pipe_source(:<<~, left, :bind, __CALLER__)
      ],
      __CALLER__
    )
  end

  defp import_pipe_module(macro_sources, env) do
    pipe_module = Module.concat(env.module, Pipe)
    create_module(pipe_module, macro_sources)

    quote do
      import unquote(pipe_module)
    end
  end

  defp pipe_source(operator, alias, function, env) do
    defoperator(operator,
      fn lhs, rhs ->
        "#{Macro.expand(alias, env)}.#{function}(#{lhs}, fn a -> a |> #{rhs} end)"
      end
    )
  end
end
