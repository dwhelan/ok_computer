defmodule OkComputer.MonadicPipe do
  @moduledoc """
  Builds monadic pipes.
  """

  @type alias :: {:__aliases__, term, term}

  @typedoc """
  A keyword list that maps pipe operators to function names.
  """
  @type operators :: [{operator :: atom, function_name :: atom}]

  alias OkComputer.Pipe
  alias OkComputer.Operator

  @doc """
  Builds a single pipe_operator_module pipe with custom pipe operators.
  """
  @spec pipe(alias, operators) :: Macro.t()
  defmacro pipe(target, operators \\ [~>: :bind, ~>>: :map]) when is_list(operators) do
    target = Macro.expand(target, __CALLER__)
    target_name = Module.split(target) |> List.last()
    pipe_module = Module.concat([__CALLER__.module, Pipe, target_name])
    operator_module = Module.concat([__CALLER__.module, Operator, target_name])

    create(target, operators, pipe_module, operator_module)

    quote do
      import unquote(pipe_module)
      import unquote(operator_module)
    end
  end

  defp create(target, operators, pipe_module, operator_module) do
    function_names = Enum.map(operators, fn {_, function_name} -> function_name end)

    Pipe.create(target, function_names, pipe_module)

    operator_bindings =
      Enum.map(
        operators,
        fn {operator, function_name} ->
          {operator, {pipe_module, function_name}}
        end
      )

    Operator.create(operator_bindings, operator_module)
  end
end
