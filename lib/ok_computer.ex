defmodule OkComputer do
  @moduledoc """
  Documentation for OkComputer.
  """

  @doc """
  Hello world.

  ## Examples

      iex> OkComputer.hello()
      :world

  """
  def hello do
    :world
  end

  defmacro __using__(_opts) do
    quote do
      use Towel
      import OkError
      import OkError.Operators
    end
  end
end
