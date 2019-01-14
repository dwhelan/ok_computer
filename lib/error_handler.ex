defmodule ErrorHandler do
  @behaviour Monad

  @type t :: Error.t
  @type error :: Error.type

  @spec return(any) :: error
  def return(:nil),        do: {:error, nil}
  def return({:ok, a}),    do: {:ok, a}
  def return({:error, a}), do: {:error, a}
  def return(a),           do: {:error, a}

  @spec bind(error, (any -> error)) :: error
  def bind({:ok, a}, f)    when is_function(f), do: {:ok, a}
  def bind({:error, a}, f) when is_function(f), do: f.(a)
end
