defmodule OkComputer.PipeOperator do
  @moduledoc """
  Builds pipes.
  """

  @type alias :: {:__aliases__, term, term}

  @typedoc """
  A set of pipe operators bound to a module with `Pipe` behaviour.
  """
  @type channel ::
          alias
          | {alias, bind_operator :: atom}
          | {:{}, term, list}
          | {alias, operators}

  @typedoc """
  A keyword list that maps pipe operators to function names.
  """
  @type operators :: [{operator :: atom, function_name :: atom}]

  @bind_operator :~>
  @map_operator :~>>
  @alternate_bind_operator :<~
  @alternate_map_operator :<<~

  @operators [
    {@bind_operator, :bind},
    {@map_operator, :map}
  ]
  @alternate_operators [
    {@alternate_map_operator, :map},
    {@alternate_bind_operator, :bind}
  ]

  import OkComputer.Operator

  defmacro pipe([]) do
    raise ArgumentError, "expected at least one channel"
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
  Builds a single channel pipe with `map` and `bind` operators.
  """
  @spec pipe(alias, bind_operator :: atom, map_operator :: atom) :: Macro.t()
  defmacro pipe({:__aliases__, line, _} = alias, bind_operator, map_operator) do
    build_channels([{:{}, line, [alias, bind_operator, map_operator]}], __CALLER__)
  end

  @doc """
  Builds a single channel pipe with a `map` operator.
  """
  @spec pipe(alias, bind_operator :: atom) :: Macro.t()
  defmacro pipe({:__aliases__, _, _} = alias, bind_operator) when is_atom(bind_operator) do
    build_channels([{alias, bind_operator}], __CALLER__)
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
  defmacro pipe({:__aliases__, _, _} = default, {:__aliases__, _, _} = alternate) do
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
    |> create_operators_module(Module.concat(env.module, Pipes))
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
    pipe_sources(alias, [{operator, :bind}], env)
  end

  defp build_channel({:{}, _, [{:__aliases__, _, _} = alias, bind_operator, map_operator]}, env)
       when is_atom(bind_operator) and is_atom(map_operator) do
    pipe_sources(alias, [{bind_operator, :bind}, {map_operator, :map}], env)
  end

  defp build_channel({{:__aliases__, _, _} = alias, operators}, env) when is_list(operators) do
    pipe_sources(alias, operators, env)
  end

  @spec pipe_sources(alias, operators, Macro.Env.t()) :: list(binary)
  defp pipe_sources(alias, operators, env) do
    import OkComputer.Pipe

    module = Macro.expand(alias, env)
    function_names = Enum.map(operators, fn {_, function_name} -> function_name end)
    pipe_module = Module.concat(env.module, module)

    create_pipe_module(module, function_names, pipe_module)

    Enum.map(operators, fn {operator, function_name} ->
      {operator, {pipe_module, function_name}}
    end)
  end
end
