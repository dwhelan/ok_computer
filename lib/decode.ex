defmodule Encode do
  @behaviour Monad

  @type ok_error :: OkError.ok_error

  @spec return(any) :: ok_error
  def return({:ok, {value, bytes, codec}}), do: {:ok, {value, bytes, codec}}
  def return({:error, reason}),             do: {:error, reason}

  @spec bind(ok_error, (any -> ok_error)) :: ok_error
  def bind({:ok, result}, map) when is_function(map) do
    with {:ok, {value, _, codec}} = map.(result) do
      apply codec, :encode, [value]
    end
  end

  def bind({:error, reason}, map) when is_function(map) do
    {:error, reason}
  end
end
