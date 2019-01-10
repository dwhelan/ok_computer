defmodule OkComputer do
  @moduledoc """
  Documentation for OkComputer.
  """

  @doc """
  """
  defmacro __using__(_opts) do
    quote do
      use Towel
      import OkError
      import OkError.Operators
    end
  end
end
