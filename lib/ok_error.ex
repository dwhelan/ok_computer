defmodule OkError do
  @behaviour Monad

  @type ok_error :: ok | error
  @type ok       :: {:ok, any}
  @type error    :: {:error, any}

  @spec ok(any) :: ok
  def ok(a), do: {:ok, a}

  @spec error(any) :: error
  def error(a), do: {:error, a}

  @spec return(any) :: ok_error
  def return(:nil),        do: {:error, nil}
  def return({:error, a}), do: {:error, a}
  def return({:ok, a}),    do: {:ok, a}
  def return(a),           do: {:ok, a}

  @spec bind(ok_error, (any -> ok_error)) :: ok_error
  def bind({:ok, a}, f)    when is_function(f), do: f.(a)
  def bind({:error, a}, f) when is_function(f), do: {:error, a}

  @spec bind_error(ok_error, (any -> ok_error)) :: ok_error
  def bind_error({:ok, a}, f)    when is_function(f), do: {:ok, a}
  def bind_error({:error, a}, f) when is_function(f), do: f.(a)

  @spec bind_first(ok_error, [(any -> ok_error), ...]) :: ok_error
  def bind_first(a, fs) when is_list(fs), do: Enum.reduce_while(fs, nil, fn f, _ -> f.(a) |> halt_if_ok end)

  defp halt_if_ok({:ok, a}),    do: {:halt, {:ok, a}}
  defp halt_if_ok({:error, a}), do: {:cont, {:error, a}}
end
