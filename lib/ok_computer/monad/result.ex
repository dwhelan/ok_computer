defmodule OkComputer.Monad.Result do
  alias OkComputer.Monad
  use Monad

  @impl Monad
  def return(value), do: {:ok, value}

  @impl Monad
  def bind({:ok, value}, f), do: f.(value)
  def bind(a, _f), do: a
end

defimpl OkComputer.PipeProtocol, for: OkComputer.Monad.Result do
  alias OkComputer.Monad.Result

  def pipe_bind(left, right) do
    quote do
      case unquote(left) do
        {:ok, _} -> Result.bind(unquote(left), fn left -> left |> unquote(right) end)
        anything_else -> anything_else
      end
    end
  end

  def pipe_map(left, right) do
    quote do
      case unquote(left) do
        {:ok, _} -> Result.map(unquote(left), fn left -> left |> unquote(right) end)
        anything_else -> anything_else
      end
    end
  end
end
