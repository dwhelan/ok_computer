defmodule OkComputer.Pipe do
  @moduledoc """
  Builds single, dual or multi-channel pipes.
  """

  @typedoc """
  A set of pipe operators bound to a module with `Pipe` behaviour.
  """
  @type channel :: {module, operators}

  @typedoc """
  A keyword list that maps operators to `Pipe` function names: `pipe_fmap` or `pipe_bind`.
  """
  @type operators :: [{operator :: atom, function_name :: atom}]

  @doc "pipe_fmap"
  @callback pipe_fmap(t :: term, (term -> term)) :: t :: term

  @doc "pipe_bind"
  @callback pipe_bind(t :: term, (term -> t :: term)) :: t :: term

  @default_operators [~>: :pipe_fmap, ~>>: :pipe_bind]
  @default_left_operators [<~: :pipe_fmap, <<~: :pipe_bind]

  import OkComputer.Operator

  defmacro __using__(_) do
    quote do
      alias OkComputer.Pipe

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
  Builds a single channel pipe with default pipe operators.
  """
  defmacro pipe({:__aliases__, _, _} = alias) do
    build_channels([{alias, @default_operators}], __CALLER__)
  end

  @doc """
  Builds a single channel pipe with a `pipe_fmap` operator.
  """
  @spec pipe({:__aliases__, term, term}, operator :: atom) :: Macro.t()
  defmacro pipe({:__aliases__, _, _} = alias, fmap_operator)
           when is_atom(fmap_operator) do
    build_channels([{alias, [{fmap_operator, :pipe_fmap}]}], __CALLER__)
  end

  @doc """
  Builds a single channel pipe with `pipe_fmap` and `pipe_bind` operators.
  """
  @spec pipe({:__aliases__, term, term}, operator :: atom, operator :: atom) :: Macro.t()
  defmacro pipe({:__aliases__, _, _} = alias, fmap_operator, bind_operator) do
    build_channels(
      [{alias, [{fmap_operator, :pipe_fmap}, {bind_operator, :pipe_bind}]}],
      __CALLER__
    )
  end

  @doc """
  Builds a single channel pipe with custom pipe operators.
  """
  @spec pipe({:__aliases__, term, term}, operators) :: Macro.t()
  defmacro pipe({:__aliases__, _, _} = alias, operators) when is_list(operators) do
    build_channels([{alias, operators}], __CALLER__)
  end

  @doc """
  Builds a dual channel pipe with default pipe operators.
  """
  @spec pipe({:__aliases__, term, term}, {:__aliases__, term, term}) :: Macro.t()
  defmacro pipe({:__aliases__, _, _} = left, {:__aliases__, _, _} = right) do
    build_channels(
      [{right, @default_operators}, {left, @default_left_operators}],
      __CALLER__
    )
  end

  @doc """
  Builds a multi channel pipe with custom pipe operators.
  """
  @spec pipe(list(channel)) :: Macro.t()
  defmacro pipe(channels) do
    build_channels(channels, __CALLER__)
  end

  @spec build_channels(list(channel), Macro.Env.t) :: Macro.t()
  defp build_channels(channels, env) do
    channels
    |> Enum.flat_map(fn
      {alias, operator} when is_atom(operator) ->
        pipe_sources(Macro.expand(alias, env), [{operator, :pipe_fmap}])

      {:{}, _, [alias, fmap_operator, bind_operator]} when is_atom(fmap_operator) and is_atom(bind_operator)->
        pipe_sources(Macro.expand(alias, env), [{fmap_operator, :pipe_fmap}, {bind_operator, :pipe_bind}])

      {alias, operators} ->
        pipe_sources(Macro.expand(alias, env), operators)
    end)
    |> defoperators(Module.concat(env.module, Pipes))
  end

  @spec pipe_sources(module, operators) :: list(binary)
  defp pipe_sources(module, operators) do
    Enum.map(operators, fn {operator, function_name} ->
      {operator, pipe_source(module, function_name)}
    end)
  end

  @spec pipe_source(module, function_name :: atom) :: binary
  defp pipe_source(module, function_name) do
    "#{module}.#{function_name}(unquote(lhs), fn a -> a |> unquote(rhs) end)"
  end
end
