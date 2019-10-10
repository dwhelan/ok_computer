defmodule OkComputer.PipeDefaultTest do
  use ExUnit.Case
  import OkComputer.Pipe

  foo OkComputer.Pipe.Value

  test :~> do
    assert :a ~> to_string() == "a"
  end

  test :~>> do
    assert :a ~>> to_string() == "a"
  end
end

defmodule OkComputer.PipeBindOnlyTest do
  use ExUnit.Case
  import OkComputer.Pipe

  foo(~>>: OkComputer.Monad.Ok)

  test :~>> do
    assert {:ok, :a} ~>> (fn a -> {:ok, to_string(a)} end).() == {:ok, "a"}
  end
end

defmodule OkComputer.PipeFmapOnlyTest do
  use ExUnit.Case
  import OkComputer.Pipe

  foo(~>: OkComputer.Monad.Ok)

  test :~> do
    assert {:ok, :a} ~> to_string() == {:ok, "a"}
  end
end

defmodule OkComputer.PipeTest do
  use ExUnit.Case

  test "must provide at least one function to pipe" do
    source = """
      defmodule EmptySwitch do
        import OkComputer.Pipe
        pipe OkComputer.Pipe.Value, []
      end
    """

    assert_raise ArgumentError, fn -> Code.eval_string(source) end
  end
end
