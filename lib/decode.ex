defmodule Encode do
  @behaviour Monad

  @type ok_error :: OkError.ok_error

  @spec return(any) :: ok_error
  def return({:ok, {value, bytes, codec}}), do: {:ok, {value, bytes, codec}}
  def return({:error, reason}),             do: {:error, reason}
#  def return(a),                            do: {:ok, {a, nil, nil}}

  @spec bind(ok_error, (any -> ok_error)) :: ok_error
  def bind({:error, a}, f) when is_function(f), do: {:error, a}# f.(a)

  def bind({:ok, {value, bytes, codec}}, f) when is_function(f) do
    case apply(codec, :encode, [value]) do
      {:ok, {value, bytes, codec}} -> f.({value, bytes, codec})
    end
  end
end
