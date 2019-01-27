defmodule Encode do
  require OkError

  def map({:ok, value}, f) when is_function(f) do
    value |> f.() |> OkError.return
  end

  def map({:error, reason}, f) when is_function(f) do
    {:error, reason}
  end
end

defmodule Decode do
  require OkError

#  def decode f, bytes do
#    value |> f.() |> OkError.return
#
#  end
end
