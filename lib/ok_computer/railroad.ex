defmodule OkComputer.Railroad do
  defmacro defrailroad() do
    quote do
      import OkComputer.Pipe
      import OkComputer.Case

      monadic_pipe
      monadic_case
    end
  end
end
