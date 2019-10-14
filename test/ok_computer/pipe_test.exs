defmodule OkComputer.PipeSingleChannelTest do
  use ExUnit.Case
  import OkComputer.Pipe
  alias OkComputer.Pipe.True

  pipe True

  test "~> should use True.pipe_fmap" do
    assert true ~> to_string() == "true"
    assert false ~> to_string() == false
  end

  test "~>> should use True.pipe_bind" do
    assert true ~> to_string() == "true"
    assert false ~>> to_string() == false
  end
end

defmodule OkComputer.PipeSingleCustomChannelTest do
  use ExUnit.Case
  import OkComputer.Pipe
  alias OkComputer.Pipe.True

  pipe True, >>>: :pipe_fmap, <~>: :pipe_bind

  test ">>> should use True.pipe_fmap" do
    assert true >>> to_string() == "true"
    assert false >>> to_string() == false
  end

  test "<~> should use True.pipe_bind" do
    assert true <~> to_string() == "true"
    assert false <~> to_string() == false
  end
end

defmodule OkComputer.PipeDualChannelTest do
  use ExUnit.Case
  import OkComputer.Pipe
  alias OkComputer.Pipe.{False, True}

  pipe False, True

  test "~> should use True.pipe_fmap" do
    assert true ~> to_string() == "true"
    assert false ~> to_string() == false
  end

  test "~>> should use True.pipe_bind" do
    assert true ~> to_string() == "true"
    assert false ~>> to_string() == false
  end

  test "<~ should use False.pipe_fmap" do
    assert false <~ to_string() == "false"
    assert true <~ to_string() == true
  end

  test "<<~ should use False. pipe_bind" do
    assert false <~ to_string() == "false"
    assert true <<~ to_string() == true
  end
end

defmodule OkComputer.PipeMultiChannelTest do
  use ExUnit.Case
  import OkComputer.Pipe
  alias OkComputer.Pipe.{Nil, False, True}

  pipe [
    {True, [~>: :pipe_fmap]},
    {False, [~>>: :pipe_fmap]},
    {Nil, [>>>: :pipe_fmap]}
  ]

  test "~> should use True.pipe_fmap" do
    assert true ~> to_string() == "true"
    assert false ~> to_string() == false
    assert nil ~> to_string() == nil
  end

  test "~>> should use False.pipe_fmap" do
    assert true ~>> to_string() == true
    assert false ~>> to_string() == "false"
    assert nil ~>> to_string() == ""
  end

  test ">>> should use Nil.pipe_fmap" do
    assert true >>> to_string() == true
    assert false >>> to_string() == false
    assert nil >>> to_string() == ""
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
