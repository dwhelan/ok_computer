defmodule OkPipe do
  @moduledoc false
  import Lily.Operator

  operator_macro(
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
