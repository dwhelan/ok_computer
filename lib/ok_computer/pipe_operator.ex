defmodule OkComputer.PipeOperator do
  @moduledoc """
  Creates pipe operators that connect operators to pipes.
  """

  alias OkComputer.{Pipe, Operator}

  @doc """
  Creates pipe operators.
  """
  @spec pipe_operators(target :: {:__aliases__, term, term}, bindings :: keyword(atom)) ::
          Macro.t()
  defmacro pipe_operators(target, bindings) do
    target = Macro.expand(target, __CALLER__)
    pipe_module = Pipe.module(target, __CALLER__)
    operator_module = Operator.module(target, __CALLER__)

    create(target, bindings, pipe_module, operator_module)

    quote do
      import unquote(operator_module)
    end
  end

  def create(target, bindings, pipe_module, operator_module) do
    Pipe.create(target, Keyword.keys(bindings), pipe_module)
    Operator.create(pipe_module, bindings, operator_module)
  end
end
