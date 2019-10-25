defmodule OkComputer.PipeTest.Single do
  import OkComputer.Pipe
  alias OkComputer.Monad.Result

  pipe Result, :map

  defmacro left ~>> right do
    map(left, right)
  end
end

defmodule OkComputer.PipeTest.SingleTest do
  use ExUnit.Case
  import OkComputer.PipeTest.Single

  test "pipe map" do
    assert {:ok, :a} ~>> to_string() == {:ok, "a"}
    assert :a ~>> to_string() == :a
  end
end

defmodule OkComputer.PipeTest.Multiple do
  import OkComputer.Pipe
  alias OkComputer.Monad.Result

  pipe Result, [:map, :bind]

  defmacro left ~> right do
    bind(left, right)
  end

  defmacro left ~>> right do
    map(left, right)
  end
end

defmodule OkComputer.PipeTest.MultipleTest do
  use ExUnit.Case
  import OkComputer.PipeTest.Multiple

  def to_string_ok(a), do: {:ok, to_string(a)}

  test "pipe bind" do
    assert {:ok, :a} ~> to_string_ok() == {:ok, "a"}
    assert :a ~> to_string_ok() == :a
  end

  test "pipe map" do
    assert {:ok, :a} ~>> to_string() == {:ok, "a"}
    assert :a ~>> to_string() == :a
  end
end
