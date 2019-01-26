defmodule Encode do
  @behaviour Monad

  @type codec    :: module
  @type encoding :: {binary, codec, any}
  @type result   :: {:ok, encoding} | {:error, any}

  @spec return(result) :: result
  def return({:ok, encoding}),  do: {:ok, encoding}
  def return({:error, reason}), do: {:error, reason}

  @spec bind(result, (any -> result)) :: result
  def bind({:ok, encoding}, map) when is_function(map) do
    with {:ok, {_, codec, value}} <- map.(encoding),
         {:ok, bytes}             <- apply(codec, :encode, [value]) do
      {:ok, {bytes, codec, value}}
    else
      error -> error
    end
  end

  def bind({:error, reason}, map) when is_function(map) do
    {:error, reason}
  end

  @spec ok(encoding) :: result
  def ok({bytes, codec, value}) when is_binary(bytes) and is_atom(codec) do
    {:ok, {bytes, codec, value}}
  end

  def encode value do

  end
end
