defmodule OkComputer.Applicative do
  @moduledoc """
  Describes applicative behaviour.
  """
  @type t :: term

  @doc "apply"
  @callback apply(t, t) :: t

  defmacro __using__(_) do
    quote do
      alias OkComputer.Applicative

      @behaviour Applicative
    end
  end
end
