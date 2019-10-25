defmodule OkComputer.PipeTest.PipeModule do
  import OkComputer.Pipe
  alias OkComputer.Monad.Result

  pipe_module Result, [:bind, :map]

  defmacro left ~> right do
    bind(left, right)
  end

  defmacro left ~>> right do
    map(left, right)
  end
end

defmodule OkComputer.PipeTest.PipeModuleTest do
  use ExUnit.Case
  alias OkComputer.PipeTest.PipeModule
  alias OkComputer.Monad.Result

  import PipeModule

  def stringify(a), do: {:ok, to_string(a)}

  test "pipe module name" do
    pipe_module_name = Module.concat(PipeModule, Result)
    assert Code.ensure_loaded?(pipe_module_name)
  end

  test "pipe bind" do
    assert {:ok, :a} ~> stringify() == {:ok, "a"}
    assert :a ~> stringify() == :a
  end

  test "pipe map" do
    assert {:ok, :a} ~>> to_string() == {:ok, "a"}
    assert :a ~>> to_string() == :a
  end
end
