defmodule OkComputer.PipeTest.MultiPipe do
  import OkComputer.Pipe
  alias OkComputer.Monad.Result

  pipe Result, [:bind, :map]

  defmacro left ~> right do
    bind(left, right)
  end

  defmacro left ~>> right do
    map(left, right)
  end
end

defmodule OkComputer.PipeTest.MultiPipeTest do
  use ExUnit.Case
  import OkComputer.PipeTest.MultiPipe

  def stringify(a), do: {:ok, to_string(a)}

  test "pipe bind" do
    assert {:ok, :a} ~> stringify() == {:ok, "a"}
    assert :a ~> stringify() == :a
  end

  test "pipe map" do
    assert {:ok, :a} ~>> to_string() == {:ok, "a"}
    assert :a ~>> to_string() == :a
  end
end
