defmodule OkComputer.PipeDefaultTest do
  use ExUnit.Case
  import OkComputer.Pipe

  pipe OkComputer.Monad.Value

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

  pipe OkComputer.Monad.Value, bind: :~>>

  test :~>> do
    assert :a ~>> to_string() == "a"
  end
end

defmodule OkComputer.PipeFmapOnlyTest do
  use ExUnit.Case
  import OkComputer.Pipe

  pipe OkComputer.Monad.Value, fmap: :~>

  test :~> do
    assert :a ~> to_string() == "a"
  end
end

defmodule OkComputer.PipeTest do
  alias OkComputer.Monad.Value

  use ExUnit.Case
  import OkComputer.Pipe

  test "must provide at least one function to pipe" do
    source = """
      defmodule EmptySwitch do
        import OkComputer.Pipe
        pipe OkComputer.Monad.Value, []
      end
    """
    assert_raise ArgumentError, fn -> Code.eval_string(source) end
  end
end
