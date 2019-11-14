defmodule OkPipe do
  import Lily.Operator

  operator_macros(
    ~>: fn left, right ->
      quote do
        case unquote(left) do
          {:ok, left} -> {:ok, left |> unquote(right)}
          left -> left
        end
      end
    end
  )
end
