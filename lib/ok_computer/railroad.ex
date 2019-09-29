defmodule OkComputer.Switch do
  defmacro monadic_switch() do
    quote do
      import OkComputer.Pipe
      import OkComputer.Case

      monadic_pipe
      monadic_case
    end
  end
end
