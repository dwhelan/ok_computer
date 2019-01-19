defmodule Encode do
  @behaviour Monad

  @type codec  :: module
  @type result :: {:ok, {any, binary, codec}} | {:error, any}

  @spec return(result) :: result
  def return({:ok, encoding}),    do: ok encoding
  def return({:error, reason}), do: {:error, reason}

  @spec bind(result, (any -> result)) :: result
  def bind({:ok, encoding}, map) when is_function(map) do
    case map.(encoding) do
      {:ok, {value, _, codec}} -> apply codec, :encode, [value]
      error -> error
    end
  end

  def bind({:error, reason}, map) when is_function(map) do
    {:error, reason}
  end

  @spec ok(any) :: result
  def ok({value, bytes, codec}) when is_binary(bytes) and is_atom(codec) do
    {:ok, {value, bytes, codec}}
  end
end
