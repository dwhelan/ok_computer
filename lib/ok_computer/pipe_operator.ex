defmodule OkComputer.PipeOperator do
  @moduledoc """
  Creates pipe operators that connect operators to pipes.
  """

  alias OkComputer.{Pipe, Operator}

  @doc """
  Creates a pipe module and an operator module and imports the operator module.
  """
  @spec pipe_operators(Macro.t(), keyword(atom)) :: Macro.t()
  defmacro pipe_operators(target, bindings) do
    target = Macro.expand(target, __CALLER__)
    pipe_module = Pipe.module(target, __CALLER__)
    operator_module = Operator.module(target, __CALLER__)

    create(target, bindings, pipe_module, operator_module)

    quote do
      import unquote(operator_module)
    end
  end

  @doc """
  Creates a pipe module and an operator module.

  It will return the result from creating the operator module.
  """
  @spec create(module, keyword(atom), module, module) :: {:module, module(), binary(), term()}
  def create(target, bindings, pipe_module, operator_module) do
    Pipe.create(target, Keyword.keys(bindings), pipe_module)
    Operator.create(pipe_module, bindings, operator_module)
  end
end
