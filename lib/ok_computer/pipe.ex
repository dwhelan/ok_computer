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
  A keyword list that maps pipe operators to `Pipe` function names: `:fmap` or `:bind` such as `[~>: :fmap]`.
  """
  @type operators :: [{operator :: atom, function_name :: atom}]

  @doc "fmap"
  @callback fmap(t :: term, (term -> term)) :: t :: term

  @doc "bind"
  @callback bind(t :: term, (term -> t :: term)) :: t :: term

  @fmap_operator :~>
  @bind_operator :~>>
  @alternate_fmap_operator :<~
  @alternate_bind_operator :<<~

  @operators [
    {@fmap_operator, :fmap},
    {@bind_operator, :bind}
  ]
  @alternate_operators [
    {@alternate_fmap_operator, :fmap},
    {@alternate_bind_operator, :bind}
  ]

  import OkComputer.Operator

  defmacro __using__(_) do
    quote do
      alias OkComputer.Pipe

      @behaviour Pipe

      @impl Pipe
      def fmap(a, f), do: bind(a, f)

      defoverridable fmap: 2
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
  Builds a single channel pipe with `fmap` and `bind` operators.
  """
  @spec pipe(alias, fmap_operator :: atom, bind_operator :: atom) :: Macro.t()
  defmacro pipe({:__aliases__, line, _} = alias, fmap_operator, bind_operator) do
    build_channels([{:{}, line, [alias, fmap_operator, bind_operator]}], __CALLER__)
  end

  @doc """
  Builds a single channel pipe with a `fmap` operator.
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
        {alternate, @alternate_operators}
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
      @operators,
      env
    )
  end

  defp build_channel({alias, operator}, env) when is_atom(operator) do
    pipe_sources(alias, [{operator, :fmap}], env)
  end

  defp build_channel({:{}, _, [{:__aliases__, _, _} = alias, fmap_operator, bind_operator]}, env)
       when is_atom(fmap_operator) and is_atom(bind_operator) do
    pipe_sources(alias, [{fmap_operator, :fmap}, {bind_operator, :bind}], env)
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
    "#{module}.#{function_name}(unquote(left), fn a -> a |> unquote(right) end)"
  end
end
