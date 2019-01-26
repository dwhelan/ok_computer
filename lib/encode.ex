defmodule Encode do
  require OkError

  def map {:ok, value}, f do
    value |> f.() |> OkError.return
  end

  def map {:error, reason}, _f do
    {:error, reason}
  end
end
