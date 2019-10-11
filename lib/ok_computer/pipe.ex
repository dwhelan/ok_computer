defmodule OkComputer.Pipe do
  @moduledoc """
  Builds monadic pipes.

  """

  @type t :: term

  @doc "bind"
  @callback bind(t, (term -> t)) :: t

  @doc "fmap"
  @callback fmap(t, (term -> term)) :: t

  defmacro __using__(_) do
    quote do
      alias OkComputer.Pipe
      import Pipe

      @behaviour Pipe

      @impl Pipe
      def fmap(a, f), do: bind(a, f)

      defoverridable fmap: 2
    end
  end

  import OkComputer.Operator

  defmacro pipe([]) do
    raise ArgumentError, "must provide at least one pipe"
  end

  # opionated
  defmacro pipe({:__aliases__, _, _} = right) do
    create_module(
      [macro_source(:~>, right, :fmap, __CALLER__), macro_source(:~>>, right, :bind, __CALLER__)],
      __CALLER__
    )
  end

  # opionated
  defmacro pipe({:__aliases__, _, _} = left, {:__aliases__, _, _} = right) do
    create_module(
      [
        macro_source(:<~, left, :fmap, __CALLER__),
        macro_source(:<<~, left, :bind, __CALLER__),
        macro_source(:~>, right, :fmap, __CALLER__),
        macro_source(:~>>, right, :bind, __CALLER__)
      ],
      __CALLER__
    )
  end
end
