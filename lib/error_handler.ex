defmodule ErrorHandler do
  @behaviour Monad

  @type t :: Error.t
  @type error :: Error.type

  @spec return(any) :: error
  def return(:nil),        do: {:error, nil}
  def return({:ok, v}),    do: {:ok, v}
  def return({:error, v}), do: {:error, v}
  def return(v),           do: {:error, v}

  @spec bind(error, (any -> error)) :: error
  def bind({:ok, v}, f)    when is_function(f), do: {:ok, v}
  def bind({:error, v}, f) when is_function(f), do: f.(v)
end
