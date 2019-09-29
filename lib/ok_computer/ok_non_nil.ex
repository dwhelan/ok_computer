defmodule OkComputer.OkNonNil do
  import OkComputer.Pipes
  alias OkComputer.Monads.{NonNil, Nil}

  defmacro __using__(opts \\ []) do
    quote do
      use OkComputer.Railroad
      import OkComputer.OkNonNil

      defpipes NonNil, Nil

      def ok?(nil), do: false
      def ok?(_), do: true
    end
  end
end
