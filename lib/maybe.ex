defmodule Maybe do
  @behaviour Monad

  @type t :: maybe
  @type maybe :: {:just, any} | :nothing

  @spec return(any) :: maybe
  def return(:nil),       do: :nothing
  def return(:nothing),   do: :nothing
  def return({:just, a}), do: {:just, a}
  def return(a),          do: {:just, a}

  @spec bind(maybe, (any -> maybe)) :: maybe
  def bind({:just, a}, f) when is_function(f), do: f.(a)
  def bind(:nothing, f)   when is_function(f), do: :nothing
end
