defmodule OkComputer.Pipe do
  @moduledoc """
  Builds multi-channel pipes.
  """

  @type t :: term

  @doc "pipe_bind"
  @callback pipe_bind(t, (term -> t)) :: t

  @doc "pipe_fmap"
  @callback pipe_fmap(t, (term -> term)) :: t

  @default_right [~>: :pipe_fmap, ~>>: :pipe_bind]
  @default_left [<~: :pipe_fmap, <<~: :pipe_bind]

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
    raise ArgumentError, "must provide at least one channel"
  end

  @doc """
  Builds a single channel pipe with default operators.
  """
  defmacro pipe({:__aliases__, _, _} = alias) do
    build_pipes([{alias, @default_right}], __CALLER__)
  end

  @doc """
  Builds a single channel pipe with custom operators.
  """
  @spec pipe({:__aliases__, term, term}, list) :: Macro.t()
  defmacro pipe({:__aliases__, _, _} = alias, operators) when is_list(operators) do
    build_pipes([{alias, operators}], __CALLER__)
  end

  @doc """
  Builds a dual channel pipe with default operators.
  """
  @spec dual_pipe({:__aliases__, term, term}, {:__aliases__, term, term}) :: Macro.t()
  defmacro dual_pipe({:__aliases__, _, _} = left, {:__aliases__, _, _} = right) do
    build_pipes([{right, @default_right}, {left, @default_left}], __CALLER__)
  end

  defp build_pipes(alias_operators, env) do
    alias_operators
    |> Enum.flat_map(fn {alias, operators} ->
      module_sources(Macro.expand(alias, env), operators)
    end)
    |> defoperators(Module.concat(env.module, Pipes))
  end

  @spec module_sources(module, keyword(function_name :: atom)) :: list(binary)
  defp module_sources(module, operators) do
    operators
    |> Enum.map(fn {operator, function_name} -> {operator, pipe_source(module, function_name)} end)
  end

  @spec pipe_source(module, function_name :: atom) :: binary
  defp pipe_source(module, function) do
#    source = quote do
#      fn a -> a |> rhs end
#    end
    "#{module}.#{function}(unquote(lhs), fn a -> a |> unquote(rhs) end)"
  end
end
