defmodule Encode do
  @behaviour Monad

  @type ok_error :: OkError.ok_error

  @spec return(any) :: ok_error
  def return({:ok, {value, bytes, codec}}), do: {:ok, {value, bytes, codec}}
  def return({:error, reason}),             do: {:error, reason}

  @spec bind(ok_error, (any -> ok_error)) :: ok_error
  def bind({:error, reason}, map) when is_function(map), do: {:error, reason}

  def bind({:ok, {value, _bytes, codec}}, map) when is_function(map) do
    case apply(codec, :encode, [value]) do
      {:ok, {value, bytes, codec}} -> map.({value, bytes, codec})
    end
  end
end
