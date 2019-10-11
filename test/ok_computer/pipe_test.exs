defmodule OkComputer.PipeRightTest do
  use ExUnit.Case
  import OkComputer.Pipe

  pipe OkComputer.Monad.Ok

  test ":~> should fmap" do
    assert {:ok, :a} ~> to_string() == {:ok, "a"}
  end

  test ":~>> should bind" do
    assert {:ok, :a} ~>> (fn a -> {:ok, "#{a}"} end).() == {:ok, "a"}
  end
end

defmodule OkComputer.PipeLeftRightTest do
  use ExUnit.Case
  import OkComputer.Pipe

  pipe OkComputer.Monad.Error, OkComputer.Monad.Ok

  test "~> should fmap right" do
    assert {:ok, :a} ~> to_string() == {:ok, "a"}
  end

  test "~>> should bind right" do
    assert {:ok, :a} ~>> (fn a -> {:ok, "#{a}"} end).() == {:ok, "a"}
  end

  test "<~ should fmap left" do
    assert {:error, :a} <~ to_string() == {:error, "a"}
  end

  test "<<~ should bind left" do
    assert {:error, :a} <<~ (fn a -> {:error, "#{a}"} end).() == {:error, "a"}
  end
end

defmodule OkComputer.PipeFmapOnlyTest do
  use ExUnit.Case
  import OkComputer.Pipe

#  pipe(~>: OkComputer.Monad.Ok)
#
#  test :~> do
#    assert {:ok, :a} ~> to_string() == {:ok, "a"}
#  end
end

defmodule OkComputer.PipeBindOnlyTest do
  use ExUnit.Case
  import OkComputer.Pipe

#  pipe(~>>: OkComputer.Monad.Ok)
#
#  test :~>> do
#    assert {:ok, :a} ~>> (fn a -> {:ok, "#{a}"} end).() == {:ok, "a"}
#  end
end

defmodule OkComputer.PipeTest do
  use ExUnit.Case

  test "must provide at least one pipe" do
    source = """
      defmodule EmptySwitch do
        import OkComputer.Pipe
        pipe []
      end
    """

    assert_raise ArgumentError, fn -> Code.eval_string(source) end
  end
end
