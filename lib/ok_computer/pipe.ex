defmodule OkComputer.Pipe do
  @moduledoc """
  Builds pipes.
  """

  @type alias :: {:__aliases__, term, term}

  @typedoc """
  A set of pipe operators bound to a module with `Pipe` behaviour.
  """
  @type channel ::
          alias
          | {alias, fmap_operator :: atom}
          | {:{}, term, list}
          | {alias, operators}

  @typedoc """
  A keyword list that maps pipe operators to `Pipe` function names: `:pipe_fmap` or `:pipe_bind` such as `[~>: :pipe_fmap]`.
  """
  @type operators :: [{operator :: atom, function_name :: atom}]

  @doc "pipe_fmap"
  @callback pipe_fmap(t :: term, (term -> term)) :: t :: term

  @doc "pipe_bind"
  @callback pipe_bind(t :: term, (term -> t :: term)) :: t :: term

  @default_pipe_fmap_operator :~>
  @default_pipe_bind_operator :~>>
  @alternate_pipe_fmap_operator :<~
  @alternate_pipe_bind_operator :<<~

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
    build_channels([alias], __CALLER__)
  end

  @doc """
  Builds a multi channel pipe with custom pipe operators.
  """
  @spec pipe(list(channel)) :: Macro.t()
  defmacro pipe(channels) do
    build_channels(channels, __CALLER__)
  end

  @doc """
  Builds a single channel pipe with `pipe_fmap` and `pipe_bind` operators.
  """
  @spec pipe(alias, fmap_operator :: atom, bind_operator :: atom) :: Macro.t()
  defmacro pipe({:__aliases__, line, _} = alias, fmap_operator, bind_operator) do
    build_channels([{:{}, line, [alias, fmap_operator, bind_operator]}], __CALLER__)
  end

  @doc """
  Builds a single channel pipe with a `pipe_fmap` operator.
  """
  @spec pipe(alias, fmap_operator :: atom) :: Macro.t()
  defmacro pipe({:__aliases__, _, _} = alias, fmap_operator) when is_atom(fmap_operator) do
    build_channels([{alias, fmap_operator}], __CALLER__)
  end

  @doc """
  Builds a single channel pipe with custom pipe operators.
  """
  @spec pipe(alias, operators) :: Macro.t()
  defmacro pipe({:__aliases__, _, _} = alias, operators) when is_list(operators) do
    build_channels([{alias, operators}], __CALLER__)
  end

  @doc """
  Builds a dual channel pipe with default pipe operators.
  """
  @spec pipe(alias, alias) :: Macro.t()
  defmacro pipe({:__aliases__, _, _} = alternate, {:__aliases__, _, _} = default) do
    build_channels(
      [
        default,
        {alternate,
         [
           {@alternate_pipe_fmap_operator, :pipe_fmap},
           {@alternate_pipe_bind_operator, :pipe_bind}
         ]}
      ],
      __CALLER__
    )
  end

  @spec build_channels(list(channel), Macro.Env.t()) :: Macro.t()
  defp build_channels(channels, env) do
    channels
    |> Enum.flat_map(fn channel -> build_channel(channel, env) end)
    |> defoperators(Module.concat(env.module, Pipes))
  end

  @spec build_channel(channel, Macro.Env.t()) :: Macro.t()
  defp build_channel({:__aliases__, _, _} = alias, env) do
    pipe_sources(
      alias,
      [{@default_pipe_fmap_operator, :pipe_fmap}, {@default_pipe_bind_operator, :pipe_bind}],
      env
    )
  end

  defp build_channel({alias, operator}, env) when is_atom(operator) do
    pipe_sources(alias, [{operator, :pipe_fmap}], env)
  end

  defp build_channel({:{}, _, [{:__aliases__, _, _} = alias, fmap_operator, bind_operator]}, env)
       when is_atom(fmap_operator) and is_atom(bind_operator) do
    pipe_sources(alias, [{fmap_operator, :pipe_fmap}, {bind_operator, :pipe_bind}], env)
  end

  defp build_channel({{:__aliases__, _, _} = alias, operators}, env) when is_list(operators) do
    pipe_sources(alias, operators, env)
  end

  @spec pipe_sources(alias, operators, Macro.Env.t()) :: list(binary)
  defp pipe_sources(alias, operators, env) do
    Enum.map(operators, fn {operator, function_name} ->
      {operator, pipe_source(Macro.expand(alias, env), function_name)}
    end)
  end

  @spec pipe_source(module, function_name :: atom) :: binary
  defp pipe_source(module, function_name) do
    "#{module}.#{function_name}(unquote(lhs), fn a -> a |> unquote(rhs) end)"
  end
end
