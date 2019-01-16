defmodule Error do
  @behaviour Monad

  @type ok :: {:ok, any}
  @type error :: {:error, any}
  @type ok_error :: ok | error

  @spec return(any) :: ok_error
  def return(:nil),        do: {:error, nil}
  def return({:ok, a}),    do: {:ok, a}
  def return({:error, a}), do: {:error, a}
  def return(a),           do: {:ok, a}

  @spec bind(ok_error, (any -> ok_error)) :: ok_error
  def bind({:ok, a}, f)    when is_function(f), do: f.(a)
  def bind({:error, a}, f) when is_function(f), do: {:error, a}

  @spec ok(any) :: ok
  def ok(a), do: return a
end
