defmodule OkComputer.PipeOperator do
  @moduledoc """
  Builds pipes.
  """

  @type alias :: {:__aliases__, term, term}

  @typedoc """
  A set of pipe operators bound to a module with `Pipe` behaviour.
  """
  @type pipe_operator_module ::
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

  alias OkComputer.Operator

  defmacro pipe([]) do
    raise ArgumentError, "expected at least one pipe_operator_module"
  end

  @doc """
  Builds a single pipe_operator_module pipe with default pipe operators.
  """
  defmacro pipe({:__aliases__, _, _} = alias) do
    create_modules([alias], __CALLER__)
  end

  @doc """
  Builds a multi pipe_operator_module pipe with custom pipe operators.
  """
  @spec pipe(list(pipe_operator_module)) :: Macro.t()
  defmacro pipe(pipe_operator_modules) do
    create_modules(pipe_operator_modules, __CALLER__)
  end

  @doc """
  Builds a single pipe_operator_module pipe with `bind` and `map` operators.
  """
  @spec pipe(alias, bind_operator :: atom, map_operator :: atom) :: Macro.t()
  defmacro pipe(alias, bind_operator, map_operator) do
    create_modules([{:{}, [], [alias, bind_operator, map_operator]}], __CALLER__)
  end

  @doc """
  Builds a single pipe_operator_module pipe with a `bind` operator.
  """
  @spec pipe(alias, bind_operator :: atom) :: Macro.t()
  defmacro pipe(alias, bind_operator) when is_atom(bind_operator) do
    create_modules([{alias, bind_operator}], __CALLER__)
  end

  @doc """
  Builds a single pipe_operator_module pipe with custom pipe operators.
  """
  @spec pipe(alias, operators) :: Macro.t()
  defmacro pipe(alias, operators) when is_list(operators) do
    create_modules([{alias, operators}], __CALLER__)
  end

  @doc """
  Builds a dual pipe_operator_module pipe with default pipe operators.
  """
  @spec pipe(alias, alias) :: Macro.t()
  defmacro pipe(default, alternate) do
    create_modules(
      [
        {default, @operators},
        {alternate, @alternate_operators}
      ],
      __CALLER__
    )
  end

  @spec create_modules(list(pipe_operator_module), Macro.Env.t()) :: Macro.t()
  defp create_modules(pipe_operator_modules, env) do
    pipe_operator_modules
    |> Enum.flat_map(fn pipe_operator_module -> create_pipe_operator_module(pipe_operator_module, env) end)
    |> Operator.create(Module.concat(env.module, Pipes))
  end

  @spec create_pipe_operator_module(pipe_operator_module, Macro.Env.t()) :: Macro.t()
  defp create_pipe_operator_module({:__aliases__, _, _} = alias, env) do
    create_module(
      alias,
      @operators,
      env
    )
  end

  defp create_pipe_operator_module({alias, operator}, env) when is_atom(operator) do
    create_module(alias, [{operator, :bind}], env)
  end

  defp create_pipe_operator_module({:{}, _, [alias, bind_operator, map_operator]}, env)
       when is_atom(bind_operator) and is_atom(map_operator) do
    create_module(alias, [{bind_operator, :bind}, {map_operator, :map}], env)
  end

  defp create_pipe_operator_module({{:__aliases__, _, _} = alias, operators}, env) when is_list(operators) do
    create_module(alias, operators, env)
  end

  @spec create_module(alias, operators, Macro.Env.t()) :: list(binary)
  defp create_module(alias, operators, env) do
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
