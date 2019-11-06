defmodule OkComputer.PipeTest do
  use ExUnit.Case
  import OkComputer.NewPipe
  alias OkComputer.Monad.Result

  pipe :~>, Result, :bind
  pipe :~>>, Result, :map

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
