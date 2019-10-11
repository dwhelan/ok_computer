defmodule OkComputer.PipeDefaultTest do
  use ExUnit.Case
  import OkComputer.Pipe

  pipe(OkComputer.Monad.Ok)

  test ":~> should fmap" do
    assert {:ok, :a} ~> to_string() == {:ok, "a"}
  end

  test ":~>> should bind" do
    assert {:ok, :a} ~>> (fn a -> {:ok, "#{a}"} end).() == {:ok, "a"}
  end
end

defmodule OkComputer.PipeBindOnlyTest do
  use ExUnit.Case
  import OkComputer.Pipe

  pipe(~>>: OkComputer.Monad.Ok)

  test :~>> do
    assert {:ok, :a} ~>> (fn a -> {:ok, "#{a}"} end).() == {:ok, "a"}
  end
end

defmodule OkComputer.PipeFmapOnlyTest do
  use ExUnit.Case
  import OkComputer.Pipe

  pipe(~>: OkComputer.Monad.Ok)

  test :~> do
    assert {:ok, :a} ~> to_string() == {:ok, "a"}
  end
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
