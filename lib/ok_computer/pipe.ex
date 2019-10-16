defmodule OkComputer.Pipe do
  @moduledoc """
  Describes pipe behaviour.
  """

  @doc "fmap"
  @callback fmap(t :: term, (term -> term)) :: t :: term

  @doc "bind"
  @callback bind(t :: term, (term -> t :: term)) :: t :: term

  defmacro __using__(_) do
    quote do
      alias OkComputer.Pipe

      @behaviour Pipe

      @impl Pipe
      def fmap(a, f), do: bind(a, f)

      defoverridable fmap: 2
    end
  end
end
