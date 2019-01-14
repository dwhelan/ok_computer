defmodule MaybeTest do
  use ExUnit.Case

  import Maybe

  use Monad.Laws

  test "return" do
    assert return(nil)          == :nothing
    assert return(:nothing)     == :nothing
    assert return({:just, "a"}) == {:just, "a"}
    assert return("a")          == {:just, "a"}
  end

  test "bind" do
    assert bind({:just, "a"}, fn a -> return "f(#{a})" end) == {:just, "f(a)"}
    assert bind(:nothing,     fn a -> return "f(#{a})" end) == :nothing
  end
end
