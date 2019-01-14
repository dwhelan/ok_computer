defmodule MaybeTest do
  use ExUnit.Case

  import Maybe

  require Monad.Laws
  use Monad.Laws

  test "return" do
    assert return(nil)          == :nothing
    assert return(:nothing)     == :nothing
    assert return({:just, "v"}) == {:just, "v"}
    assert return("v")          == {:just, "v"}
  end

  test "bind" do
    assert bind({:just, "v"}, fn _ -> {:just, "V"} end) == {:just, "V"}
    assert bind(:nothing,     fn _ -> {:just, "V"} end) == :nothing
  end
end
