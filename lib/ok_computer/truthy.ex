defmodule OkComputer.Truthy do
  defmacro __using__(opts \\ []) do
    quote do
      import OkComputer.Monad
      import OkComputer.Pipes
      import OkComputer.Case

      monad()

      def ok?(nil), do: false
      def ok?(false), do: false
      def ok?(_), do: true
    end
  end
end
