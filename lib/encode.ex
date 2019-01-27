defmodule Encode do
  import OkError

#  def map({:error, reason}, _) do
#    {:error, reason}
#  end
#
#  def map({:ok, value}, f) when is_function(f) do
#    value |> f.() |> return
#  end
end

defmodule Decode do

  defmacro __using__ _ do
    quote do
      def decode <<>> do
        {:error, {:insufficient_bytes, <<>>}}
      end
    end
  end
end
