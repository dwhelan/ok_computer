defmodule OkComputer.Monad do
  defmacro __using__(opts \\ []) do
    quote do
      import OkComputer.Monad
      import OkComputer.Pipes
      import OkComputer.Case
    end
  end

  defmacro monad do
    quote do
      def error?(value), do: not ok?(value)
    end
  end
end
