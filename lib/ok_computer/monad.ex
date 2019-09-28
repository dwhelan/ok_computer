defmodule OkComputer.Monad do
  defmacro monad do
    quote do
      import OkComputer.Pipes
      import OkComputer.Case

      def error?(value), do: not ok?(value)
    end
  end
end
