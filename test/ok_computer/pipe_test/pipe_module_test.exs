defmodule OkComputer.PipeTest.PipeModule do
  import OkComputer.Pipe
  alias OkComputer.Monad.Result

  pipe_module Result, :map

  defmacro left ~>> right do
    map(left, right)
  end
end

defmodule OkComputer.PipeTest.PipeModuleTest do
  use ExUnit.Case
  import OkComputer.PipeTest.PipeModule

  test "pipe module name" do
  end

  test "pipe map" do
    assert {:ok, :a} ~>> to_string() == {:ok, "a"}
    assert :a ~>> to_string() == :a
  end
end
