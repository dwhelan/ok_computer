defmodule OkComputer.PipeOperator do
  @moduledoc """
  Creates pipe operators that connect operators to pipes.
  """

  @doc """
  Builds a pipe operator.
  """
  @spec pipe_operator(target :: {:__aliases__, term, term}, bindings :: keyword(atom)) ::
          Macro.t()
  defmacro pipe_operator(target, bindings) do
    target = Macro.expand(target, __CALLER__)
    target_name = Module.split(target) |> List.last()
    pipe_module = Module.concat([__CALLER__.module, Pipe, target_name])
    operator_module = Module.concat([__CALLER__.module, Operator, target_name])

    create(target, bindings, pipe_module, operator_module)

    quote do
      import unquote(operator_module)
    end
  end

  def create(target, bindings, pipe_module, operator_module) do
    OkComputer.Pipe.create(pipe_module, target, function_names(bindings))
    OkComputer.Operator.create(pipe_module, bindings, operator_module)
  end

  defp function_names(bindings) do
    Enum.map(bindings, fn {function_name, _} -> function_name end)
  end
end
