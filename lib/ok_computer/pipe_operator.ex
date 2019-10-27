defmodule OkComputer.PipeOperator do
  @moduledoc """
  Creates pipe operators that connect operators to pipes.
  """

  @doc """
  Builds a pipe operator.
  """
  @spec pipe_operators(target :: {:__aliases__, term, term}, bindings :: keyword(atom)) ::
          Macro.t()
  defmacro pipe_operators(target, bindings) do
    target = Macro.expand(target, __CALLER__)
    target_name = Module.split(target) |> List.last()
    pipe_module = Module.concat([__CALLER__.module, Pipe, target_name])
    operator_module = Module.concat([__CALLER__.module, Operator, target_name])

    create(pipe_module, OkComputer.Operator.operator_module(__CALLER__.module, target), target, bindings)

    quote do
      import unquote(operator_module)
    end
  end

  def create(pipe_module, operator_module, target, bindings) do
    OkComputer.Pipe.create(pipe_module, target, function_names(bindings))
    OkComputer.Operator.create(operator_module, pipe_module, bindings)
  end

  defp function_names(bindings) do
    Enum.map(bindings, fn {function_name, _} -> function_name end)
  end
end
