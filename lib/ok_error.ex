defmodule OkError do
  @behaviour Monad

  @type ok_error :: ok | error
  @type ok       :: {:ok, any}
  @type error    :: {:error, any}

  @spec return(any) :: ok_error
  def return(:nil),        do: {:error, nil}
  def return({:error, a}), do: {:error, a}
  def return({:ok, a}),    do: {:ok, a}
  def return(a),           do: {:ok, a}

  @spec bind(ok_error, (any -> ok_error)) :: ok_error
  def bind({:ok, a}, f)    when is_function(f), do: f.(a)
  def bind({:error, a}, f) when is_function(f), do: {:error, a}

  @spec ok(any) :: ok
  def ok(a), do: {:ok, a}

  @spec error(any) :: error
  def error(a), do: {:error, a}

  defmacro a ~> f  do
    pipe_bind a, f
  end

  defp pipe_bind(a, f = {atom, _, _}) when atom in [:fn, :&] do
    quote location: :keep, do: unquote(a) |> bind(unquote f)
  end

  defp pipe_bind a, f do
    quote location: :keep, do: unquote(a) |> bind(&unquote(f)/1)
  end
end
