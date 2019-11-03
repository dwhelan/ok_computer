defmodule OkComputer.PipeTest.NewSinglePipeTest do
  use ExUnit.Case
  import OkComputer.NewPipe
  alias OkComputer.Monad.Result

  pipe :~>, Result, :map

  test "pipe map" do
    assert {:ok, :a} ~> to_string() == {:ok, "a"}
    assert :a ~> to_string() == :a
  end
end
