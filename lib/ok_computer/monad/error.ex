defmodule OkComputer.Monad.Error do
  alias OkComputer.Monad
  use Monad

  @impl Monad
  def return(reason), do: {:error, reason}

  @impl Monad
  def bind({:error, reason}, f), do: f.(reason)
  def bind(a, _f), do: a
end

defimpl OkComputer.PipeProtocol, for: OkComputer.Monad.Error do
  alias OkComputer.Monad.Error

  def pipe_bind(left, right) do
    quote do
      case unquote(left) do
        {:error, _} -> Error.bind(unquote(left), fn left -> left |> unquote(right) end)
        anything_else -> anything_else
      end
    end
  end

  def pipe_map(left, right) do
    quote do
      case unquote(left) do
        {:error, _} -> Error.map(unquote(left), fn left -> left |> unquote(right) end)
        anything_else -> anything_else
      end
    end
  end
end

