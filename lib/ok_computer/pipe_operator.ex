defmodule OkComputer.PipeOperator do
  @moduledoc """
  Creates pipe operators that connect operators to pipes.
  """

  alias OkComputer.{Pipe, Operator}

  @doc """
  Builds a pipe operator.
  """
  @spec pipe_operators(target :: {:__aliases__, term, term}, bindings :: keyword(atom)) ::
          Macro.t()
  defmacro pipe_operators(target, bindings) do
    target = Macro.expand(target, __CALLER__)
    pipe_module = Pipe.module(__CALLER__.module, target)
    operator_module = Operator.module(__CALLER__.module, target)

    create(pipe_module, operator_module, target, bindings)

    quote do
      import unquote(operator_module)
    end
  end

  def create(env = %Macro.Env{}, target, bindings) do
    Pipe.create(env, target, function_names(bindings))
    Operator.create(env, target, bindings)
  end

  def create(pipe_module, operator_module, target, bindings) do
    Pipe.create(pipe_module, target, function_names(bindings))
    Operator.create(operator_module, pipe_module, bindings)
  end

  defp function_names(bindings) do
    Enum.map(bindings, fn {function_name, _} -> function_name end)
  end
end
