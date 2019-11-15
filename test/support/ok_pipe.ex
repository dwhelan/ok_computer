defmodule OkPipe do
  import Lily.Operator

  defoperator_macros(
    ~>: fn a, f ->
      quote do
        case unquote(a) do
          {:ok, a} -> {:ok, a |> unquote(f)}
          a -> a
        end
      end
    end
  )
end
