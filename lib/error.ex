defmodule Error do
  @behaviour Monad

  @type ok_error :: OkError.ok_error

  @spec return(any) :: ok_error
  def return(:nil),        do: {:error, nil}
  def return({:ok, a}),    do: {:ok, a}
  def return({:error, a}), do: {:error, a}
  def return(a),           do: {:error, a}

  @spec bind(ok_error, (any -> ok_error)) :: ok_error
  def bind({:ok, a}, f)    when is_function(f), do: {:ok, a}
  def bind({:error, a}, f) when is_function(f), do: f.(a)

  @spec ok(any) :: OkError.ok
  def ok(a), do: {:ok, a}

  @spec error(any) :: OkError.error
  def error(a), do: {:error, a}
end
