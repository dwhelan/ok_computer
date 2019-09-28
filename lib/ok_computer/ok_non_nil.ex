defmodule OkComputer.OkNonNil do
  def bind(nil, f), do: nil
  def bind(a, f), do: f.(a)

  defmacro __using__(opts \\ []) do
    quote do
      use OkComputer.Monad
      import OkComputer.OkNonNil

      def ok?(nil), do: false
      def ok?(_), do: true
    end
  end
end
