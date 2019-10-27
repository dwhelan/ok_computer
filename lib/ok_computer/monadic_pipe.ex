defmodule OkComputer.MonadicPipe do
  @moduledoc """
  Builds monadic pipes.
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

  @operators [
    {@bind_operator, :bind},
    {@map_operator, :map}
  ]

  alias OkComputer.Pipe
  alias OkComputer.Operator

  @doc """
  Builds a single pipe_operator_module pipe with custom pipe operators.
  """
  @spec pipe(alias, operators) :: Macro.t()
  defmacro pipe(alias, operators \\ @operators) when is_list(operators) do
    module = Macro.expand(alias, __CALLER__)
    pipe_module = Module.concat(__CALLER__.module, module)
    create(module, operators, pipe_module)
    |> Operator.create(Module.concat(__CALLER__.module, Pipes))
  end

  defp create(module, operators, pipe_module) do
    function_names = Enum.map(operators, fn {_, function_name} -> function_name end)

    Pipe.create(module, function_names, pipe_module)

    Enum.map(operators, fn {operator, function_name} ->
      {operator, {pipe_module, function_name}}
    end)
  end
end
