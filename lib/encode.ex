defmodule Encode do
  @behaviour Monad

  @type codec  :: module
  @type result :: {:ok, {binary, codec, any}} | {:error, any}

  @spec return(result) :: result
  def return({:ok, encoding}),    do: ok encoding
  def return({:error, reason}), do: {:error, reason}

  @spec bind(result, (any -> result)) :: result
  def bind({:ok, encoding}, map) when is_function(map) do
    case map.(encoding) do
      {:ok, {_, codec, value}} -> apply codec, :encode, [value]
      error -> error
    end
  end

  def bind({:error, reason}, map) when is_function(map) do
    {:error, reason}
  end

  @spec ok(any) :: result
  def ok({bytes, codec, value}) when is_binary(bytes) and is_atom(codec) do
    {:ok, {bytes, codec, value}}
  end
end
