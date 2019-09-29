defmodule OkComputer.NonNil do
  def bind(nil, f), do: nil
  def bind(a, f), do: f.(a)

  defmacro __using__(opts \\ []) do
    quote do
      use OkComputer.Railroad
      import OkComputer.NonNil

      def ok?(nil), do: false
      def ok?(_), do: true
    end
  end
end
