defmodule Error do
  @behaviour Monad

  @type t :: error
  @type error :: {:ok, any} | {:error, any}

  @spec return(any) :: error
  def return(:nil),        do: {:error, nil}
  def return({:ok, v}),    do: {:ok, v}
  def return({:error, v}), do: {:error, v}
  def return(v),           do: {:ok, v}

  @spec bind(error, (any -> error)) :: error
  def bind({:ok, v}, f)    when is_function(f), do: f.(v)
  def bind({:error, v}, f) when is_function(f), do: {:error, v}
end
