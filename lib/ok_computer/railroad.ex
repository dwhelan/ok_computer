defmodule OkComputer.Railroad do
  defmacro __using__(opts \\ []) do
    quote do
      import OkComputer.Pipes
      import OkComputer.Case
    end
  end
end
