defmodule Error do
  @behaviour Monad

  @type ok_error :: OkError.ok_error

  @spec return(any) :: ok_error
  def return(:nil),        do: {:error, nil}
  def return({:ok, a}),    do: {:ok, a}
  def return({:error, b}), do: {:error, b}
  def return(a),           do: {:error, a}

  @spec bind(ok_error, (any -> ok_error)) :: ok_error
  def bind({:ok, a}, f)    when is_function(f), do: {:ok, a}
  def bind({:error, b}, f) when is_function(f), do: f.(b)

  @spec ok(any) :: OkError.ok
  def ok(a), do: {:ok, a}

  @spec error(any) :: OkError.error
  def error(b), do: {:error, b}
end
