defmodule Lily.Tee do
  @moduledoc false
  import Lily.Operator

  def tee(tee) do
    fn a, f ->
      quote do
        a = unquote(a)
        unquote(tee).(a)
        a |> unquote(f)
      end
    end
  end

  defoperator_macros(
    ~>: fn a, f ->
      quote do
        IO.inspect(a = unquote(a))
        a |> unquote(f)
      end
    end
  )
end
