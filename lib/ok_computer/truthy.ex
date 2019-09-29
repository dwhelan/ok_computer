defmodule OkComputer.Truthy do
  def bind(nil, f), do: nil
  def bind(false, f), do: false
  def bind(a, f), do: f.(a)

  defmacro __using__(opts \\ []) do
    quote do
      use OkComputer.Railroad
      import OkComputer.Truthy

      def ok?(nil), do: false
      def ok?(false), do: false
      def ok?(_), do: true
    end
  end
end
