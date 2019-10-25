defmodule OkComputer.PipeTest.SinglePipe do
  import OkComputer.Pipe
  alias OkComputer.Monad.Result

  pipes Result, :map

  defmacro left ~>> right do
    map(left, right)
  end
end

defmodule OkComputer.PipeTest.SinglePipeTest do
  use ExUnit.Case
  import OkComputer.PipeTest.SinglePipe

  test "pipe map" do
    assert {:ok, :a} ~>> to_string() == {:ok, "a"}
    assert :a ~>> to_string() == :a
  end
end
