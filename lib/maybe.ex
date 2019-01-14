defmodule Maybe do
  @behaviour Monad

  @type maybe :: {:just, any} | :nothing
  @type t :: maybe

  @spec return(any) :: maybe
  def return(:nil),       do: :nothing
  def return(:nothing),   do: :nothing
  def return({:just, v}), do: {:just, v}
  def return(v),          do: {:just, v}

  @spec bind(maybe, (any -> maybe)) :: maybe
  def bind({:just, v}, f) when is_function(f), do: f.(v)
  def bind(:nothing, f)   when is_function(f), do: :nothing
end
