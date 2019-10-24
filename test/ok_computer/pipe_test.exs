defmodule OkComputer.PipeTest.Functions do
  import OkComputer.Pipe
  alias OkComputer.Monad.Result

  pipe {:map, Result}

  defmacro left ~> right do
    map(left, right)
  end
end

defmodule OkComputer.PipeTest do
  use ExUnit.Case
  import OkComputer.PipeTest.Functions

  test "pipe" do
    assert {:ok, :a} ~> to_string() == {:ok, "a"}
  end
end
