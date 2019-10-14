defmodule OkComputer.PipeRightTest do
  use ExUnit.Case
  import OkComputer.Pipe
  alias OkComputer.Pipe.True

  pipe True

  test "~> should apply True.pipe_fmap" do
    assert true ~> to_string() == "true"
    assert false ~> to_string() == false
  end

  test "~>> should apply True.pipe_bind" do
    assert true ~> to_string() == "true"
    assert false ~>> to_string() == false
  end
end

defmodule OkComputer.PipeCustomRightTest do
  use ExUnit.Case
  import OkComputer.Pipe
  alias OkComputer.Pipe.True

  pipe True, >>>: :pipe_fmap, <~>: :pipe_bind

  test ">>> should apply True.pipe_fmap" do
    assert true >>> to_string() == "true"
    assert false >>> to_string() == false
  end

  test "<~> should apply True.pipe_bind" do
    assert true <~> to_string() == "true"
    assert false <~> to_string() == false
  end
end

defmodule OkComputer.PipeLeftRightTest do
  use ExUnit.Case
  import OkComputer.Pipe
  alias OkComputer.Pipe.{False, True}

  dual_pipe(False, True)

  test "~> should apply True.pipe_fmap" do
    assert true ~> to_string() == "true"
    assert false ~> to_string() == false
  end

  test "~>> should apply True.pipe_bind" do
    assert true ~> to_string() == "true"
    assert false ~>> to_string() == false
  end

  test "<~ should apply False.pipe_fmap" do
    assert false <~ to_string() == "false"
    assert true <~ to_string() == true
  end

  test "<<~ should apply False. pipe_bind" do
    assert false <~ to_string() == "false"
    assert true <<~ to_string() == true
  end
end

defmodule OkComputer.PipeTest do
  use ExUnit.Case

  test "must provide at least one pipe" do
    source = """
      defmodule BadPipe do
        import OkComputer.Pipe
        pipe []
      end
    """

    assert_raise ArgumentError, fn -> Code.eval_string(source) end
  end
end
