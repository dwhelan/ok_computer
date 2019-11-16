defmodule InspectPipe do
  @moduledoc false
  import Lily.Operator

  defoperator_macros(
    ~>: fn a, f ->
      quote do
        IO.inspect(a = unquote(a))
        a |> unquote(f)
      end
    end
  )
end
