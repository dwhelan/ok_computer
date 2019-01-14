defmodule Error do
  @behaviour Monad

  @type t :: error
  @type error :: {:ok, any} | {:error, any}

  @spec return(any) :: error
  def return(:nil),        do: {:error, nil}
  def return({:ok, a}),    do: {:ok, a}
  def return({:error, a}), do: {:error, a}
  def return(a),           do: {:ok, a}

  @spec bind(error, (any -> error)) :: error
  def bind({:ok, a}, f)    when is_function(f), do: f.(a)
  def bind({:error, a}, f) when is_function(f), do: {:error, a}
end
