defmodule OkComputer.Builder.SingleChannelTest do
  use ExUnit.Case
  import OkComputer.Builder
  alias OkComputer.Pipe.True

  pipe True

  test "~> should use True.fmap" do
    assert true ~> to_string() == "true"
    assert false ~> to_string() == false
  end

  test "~>> should use True.bind" do
    assert true ~>> to_string() == "true"
    assert false ~>> to_string() == false
  end
end

defmodule OkComputer.PipeSingleChannelWithSingleOperatorTest do
  use ExUnit.Case
  import OkComputer.Builder
  alias OkComputer.Pipe.True

  pipe True, :>>>

  test ">>> should use True.fmap" do
    assert true >>> to_string() == "true"
    assert false >>> to_string() == false
  end
end

defmodule OkComputer.PipeSingleChannelWithTwoOperatorsTest do
  use ExUnit.Case
  import OkComputer.Builder
  alias OkComputer.Pipe.True

  pipe True, :>>>, :<~>

  test ">>> should use True.fmap" do
    assert true >>> to_string() == "true"
    assert false >>> to_string() == false
  end

  test "<~> should use True.bind" do
    assert true <~> to_string() == "true"
    assert false <~> to_string() == false
  end
end

defmodule OkComputer.PipeSingleChannelWithOperatorsTest do
  use ExUnit.Case
  import OkComputer.Builder
  alias OkComputer.Pipe.True

  pipe True, >>>: :fmap, <~>: :bind

  test ">>> should use True.fmap" do
    assert true >>> to_string() == "true"
    assert false >>> to_string() == false
  end

  test "<~> should use True.bind" do
    assert true <~> to_string() == "true"
    assert false <~> to_string() == false
  end
end

defmodule OkComputer.PipeDualChannelTest do
  use ExUnit.Case
  import OkComputer.Builder
  alias OkComputer.Pipe.{False, True}

  pipe False, True

  test "~> should use True.fmap" do
    assert true ~> to_string() == "true"
    assert false ~> to_string() == false
  end

  test "~>> should use True.bind" do
    assert true ~> to_string() == "true"
    assert false ~>> to_string() == false
  end

  test "<~ should use False.fmap" do
    assert false <~ to_string() == "false"
    assert true <~ to_string() == true
  end

  test "<<~ should use False. bind" do
    assert false <~ to_string() == "false"
    assert true <<~ to_string() == true
  end
end

defmodule OkComputer.PipeMultiChannelWithSingleOperatorTest do
  use ExUnit.Case
  import OkComputer.Builder
  alias OkComputer.Pipe.{False, True}

  pipe [{True, :~>}, {False, :<~}]

  test "~> should use True.fmap" do
    assert true ~> to_string() == "true"
    assert false ~> to_string() == false
    assert nil ~> to_string() == nil
  end

  test "<~ should use False.fmap" do
    assert true <~ to_string() == true
    assert false <~ to_string() == "false"
    assert nil <~ to_string() == ""
  end
end

defmodule OkComputer.PipeMultiChannelWithTwoOperatorsTest do
  use ExUnit.Case
  import OkComputer.Builder
  alias OkComputer.Pipe.{Nil, False, True}

  pipe [{True, :~>, :~>>}, {False, :<~, :<<~}]

  test "~> should use True.fmap" do
    assert true ~> to_string() == "true"
    assert false ~> to_string() == false
    assert nil ~> to_string() == nil
  end

  test "<~ should use False.fmap" do
    assert true <~ to_string() == true
    assert false <~ to_string() == "false"
    assert nil <~ to_string() == ""
  end
end

defmodule OkComputer.PipeMultiChannelTest do
  use ExUnit.Case
  import OkComputer.Builder
  alias OkComputer.Pipe.{Nil, False, True}

  pipe [
    {True, [~>: :fmap]},
    {False, [~>>: :fmap]},
    {Nil, [>>>: :fmap]}
  ]

  test "~> should use True.fmap" do
    assert true ~> to_string() == "true"
    assert false ~> to_string() == false
    assert nil ~> to_string() == nil
  end

  test "~>> should use False.fmap" do
    assert true ~>> to_string() == true
    assert false ~>> to_string() == "false"
    assert nil ~>> to_string() == ""
  end

  test ">>> should use Nil.fmap" do
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
        import OkComputer.Builder
        pipe []
      end
    """

    assert_raise ArgumentError, fn -> Code.eval_string(source) end
  end
end
