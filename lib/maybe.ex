defmodule Maybe do
  @behaviour Monad

  @type just :: {:just, any}
  @type nothing :: :nothing
  @type maybe :: just | nothing

  @spec return(any) :: maybe
  def return(:nil),       do: :nothing
  def return(:nothing),   do: :nothing
  def return({:just, a}), do: {:just, a}
  def return(a),          do: {:just, a}

  @spec bind(maybe, (any -> maybe)) :: maybe
  def bind({:just, a}, f) when is_function(f), do: f.(a)
  def bind(:nothing, f)   when is_function(f), do: :nothing

  @spec just(any) :: just
  def just(a), do: {:just, a}
end
