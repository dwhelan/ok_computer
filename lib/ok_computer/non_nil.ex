defmodule OkComputer.NonNil do
  defmacro __using__(opts \\ []) do
    quote do
      use OkComputer.Monad

      monad()

      def ok?(nil), do: false
      def ok?(_), do: true

      def bind(nil, f), do: nil
      def bind(a, f), do: f.(a)
    end
  end
end
