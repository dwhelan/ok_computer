defmodule Lily.Function do
  @moduledoc false

  @doc """
  Returns the arity of a quoted function.

  ## Examples

      iex> arity quote(do: fn _ -> nil end), __ENV__
      1
      iex> arity quote(do: fn _, _ -> nil end), __ENV__
      2
  """
  @spec arity(Macro.t(), Macro.Env.t()) :: integer
  def arity(f, env) do
    {f, _} = Code.eval_quoted(f, [], env)
    {:arity, arity} = Function.info(f, :arity)
    arity
  end
end
