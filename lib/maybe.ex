defmodule Maybe do
  @behaviour Monad

  @type t :: {:just, any} | :nothing

  def atoms(), do: [:just, :nothing]

  @spec return(any) :: t
  def return(:nil),       do: :nothing
  def return(:nothing),   do: :nothing
  def return({:just, v}), do: {:just, v}
  def return(v),          do: {:just, v}

  @spec bind(t, (any -> t)) :: t
  def bind({:just, v}, f) when is_function(f), do: f.(v)
  def bind(:nothing, f)   when is_function(f), do: :nothing
end
