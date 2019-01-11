defprotocol OkError do
  def when_ok(o, f)
  def when_error(o, f)
end

defimpl OkError, for: List do
  def when_ok(o, f)    when is_function(f), do: bind(o, f)
  def when_error(o, f) when is_function(f), do: bind(o, f)

  defp bind(o, f), do: Monad.bind(o, f) |> Result.wrap
end

defimpl OkError, for: Tuple do
  import Result

  def when_ok({:ok, v}, f) when is_function(f), do: v |> f.() |> wrap
  def when_ok({:error, _} = o, _), do: o

  def when_error({:ok, _} = o, _), do: o
  def when_error({:error, v}, f) when is_function(f), do: v |> f.() |> wrap_as_error

  defp wrap_as_error({:ok, _} = o), do: o
  defp wrap_as_error(:error),       do: error()
  defp wrap_as_error(nil),          do: error()
  defp wrap_as_error(v),            do: error(v)
end

defmodule OkError.Operators do
  defmacro o ~> f do
    quote do
      unquote(o) |> when_ok(unquote f)
    end
  end

  defmacro o ~>> f do
    quote do
      unquote(o) |> when_error(unquote f)
    end
  end

  defmacro o <<< f do
    quote do
      unquote(o) |> start_exception(unquote f)
    end
  end

  def start_exception(o, f) do
    try do
      OkError.when_ok(o, f)
    rescue
      e -> Result.error(e)
    end
  end
end
