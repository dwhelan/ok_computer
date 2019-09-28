defmodule OkComputer.Monad do
  defmacro __using__(opts \\ []) do
    quote do
      import OkComputer.Monad
      import OkComputer.Pipes
      import OkComputer.Case
    end
  end
end
