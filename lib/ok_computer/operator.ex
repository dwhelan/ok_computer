defmodule OkComputer.Operator do
  @moduledoc """
  Creates operators dynamically.
  """

  @doc """
  Creates operators dynamically.

  ## Examples

      iex>alias OkComputer.Operator
      ...>defoperators
      
  """
  defmacro defoperators(operators) do
    __CALLER__.module
    |> Module.concat(Operators)
    |> defoperators(operators)
  end

  def defoperators(module, operators) do
    Code.compile_string("""
      defmodule #{module} do
        #{Enum.map(operators, &defoperator/1)}
      end
    """)

    quote do
      import unquote(module)
    end
  end

  defp defoperator({operator, source}) do
    """
      defmacro lhs #{operator} rhs do
        quote do
          #{source}
         end
      end
    """
  end
end
