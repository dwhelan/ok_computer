defmodule OkComputer.Pipes do
  defmacro left ~> right do
    quote do
      value = unquote(left)

      case ok?(value) do
        true -> unquote(Macro.pipe(left, right, 0))
        false -> value
      end
    end
  end

  defmacro left ~>> right do
    quote do
      value = unquote(left)

      case error?(value) do
        true -> unquote(Macro.pipe(left, right, 0))
        false -> value
      end
    end
  end
end
