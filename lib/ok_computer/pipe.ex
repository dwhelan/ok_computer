defmodule OkComputer.Pipe do
  @moduledoc """
  Builds multi-channel pipes.
  """

  @type t :: term

  @doc "pipe_bind"
  @callback pipe_bind(t, (term -> t)) :: t

  @doc "pipe_fmap"
  @callback pipe_fmap(t, (term -> term)) :: t

  import OkComputer.Operator

  defmacro __using__(_) do
    quote do
      alias OkComputer.Pipe
      import Pipe

      @behaviour Pipe

      @impl Pipe
      def pipe_fmap(a, f), do: pipe_bind(a, f)

      defoverridable pipe_fmap: 2
    end
  end

  defmacro pipe([]) do
    raise ArgumentError, "must provide at least one pipe"
  end

  defmacro pipe({:__aliases__, _, _} = right) do
    right = Macro.expand(right, __CALLER__)

    _pipes(__CALLER__,
      ~>: _pipe(right, :pipe_fmap),
      ~>>: _pipe(right, :pipe_bind)
    )
  end

  defmacro pipe({:__aliases__, _, _} = right, fmap, bind) do
    right = Macro.expand(right, __CALLER__)

    _pipes(
      __CALLER__,
      [{fmap, _pipe(right, :pipe_fmap)}, {bind, _pipe(right, :pipe_bind)}]
    )
  end

  defmacro pipe({:__aliases__, _, _} = left, {:__aliases__, _, _} = right) do
    left = Macro.expand(left, __CALLER__)
    right = Macro.expand(right, __CALLER__)

    _pipes(__CALLER__, [
      ~>: _pipe(right, :pipe_fmap),
      ~>>: _pipe(right, :pipe_bind),
      <~: _pipe(left, :pipe_fmap),
      <<~: _pipe(left, :pipe_bind)
    ])
  end

  defp _pipes(env, pipes) do
    module = Module.concat(env.module, Pipes)
    defoperators(module,pipes)
  end

  defp _pipe(module, function) do
    "#{module}.#{function}(unquote(lhs), fn a -> a |> unquote(rhs) end)"
  end
end
