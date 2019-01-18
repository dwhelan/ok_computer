defmodule Encode do
  @behaviour Monad

  @type ok_error :: OkError.ok_error

  @spec return(any) :: ok_error
  def return({:ok, {value, codec, bytes}}), do: {:ok, {value, codec, bytes}}
  def return({:error, reason}),             do: {:error, reason}
#  def return(a),                            do: {:ok, {a, nil, nil}}

  @spec bind(ok_error, (any -> ok_error)) :: ok_error
  def bind({:error, a}, f) when is_function(f), do: {:error, a}# f.(a)
  def bind({:ok, a}, f)    when is_function(f), do: {:ok, a}
end
