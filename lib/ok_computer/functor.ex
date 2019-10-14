defmodule OkComputer.Functor do
  @moduledoc """
  Describes functor behaviour.
  """
  @type t :: term

  @doc "fmap"
  @callback fmap(t, (term -> term)) :: t

  defmacro __using__(_) do
    quote do
      alias OkComputer.Functor

      @behaviour Functor
    end
  end
end
