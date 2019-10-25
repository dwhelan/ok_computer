defmodule OkComputer.PipeOperatorTests do
  defmacro assert_Result_bind do
    quote do
      test "~>> should be Result.bind" do
        f = fn :value -> {:ok, "value"} end

        assert {:ok, :value} ~>> f.() == {:ok, "value"}
        assert :anything_else ~>> f.() == :anything_else
      end
    end
  end

  defmacro assert_Result_map do
    quote do
      test "~> should be Result.map" do
        f = fn :value -> "value" end

        assert {:ok, :value} ~> f.() == {:ok, "value"}
        assert :anything_else ~> f.() == :anything_else
      end
    end
  end

  defmacro assert_Error_bind do
    quote do
      test "<<~ should be Error.bind" do
        f = fn :reason -> {:error, "reason"} end

        assert {:error, :reason} <<~ f.() == {:error, "reason"}
        assert :anything_else <<~ f.() == :anything_else
      end
    end
  end

  defmacro assert_Error_map do
    quote do
      test "<~ should be Error.map" do
        f = fn :reason -> "reason" end

        assert {:error, :reason} <~ f.() == {:error, "reason"}
        assert :anything_else <~ f.() == :anything_else
      end
    end
  end

  defmacro __using__(_) do
    quote do
      use ExUnit.Case
      import OkComputer.PipeOperatorTests
      import OkComputer.PipeOperator
      alias OkComputer.Monad.Result
    end
  end
end

defmodule OkComputer.PipeOperator.SingleChannelTest do
  use OkComputer.PipeOperatorTests
  alias OkComputer.Monad.Result

  pipe(Result)

  assert_Result_bind()
  assert_Result_map()
end

defmodule OkComputer.PipeSingleChannelWithSingleOperatorTest do
  use OkComputer.PipeOperatorTests
  alias OkComputer.Monad.Result

  pipe(Result, :~>)

  assert_Result_map()
end

defmodule OkComputer.PipeSingleChannelWithTwoOperatorsTest do
  use OkComputer.PipeOperatorTests
  alias OkComputer.Monad.Result

  pipe(Result, :~>, :~>>)

  assert_Result_bind()
  assert_Result_map()
end

defmodule OkComputer.PipeSingleChannelWithOperatorsTest do
  use OkComputer.PipeOperatorTests
  alias OkComputer.Monad.Result

  pipe(Result, ~>: :map, ~>>: :bind)

  assert_Result_bind()
  assert_Result_map()
end

defmodule OkComputer.PipeDualChannelTest do
  use OkComputer.PipeOperatorTests
  alias OkComputer.Monad.{Result, Error}

  pipe(Result, Error)

  assert_Result_bind()
  assert_Result_map()
  assert_Error_bind()
  assert_Error_map()
end

defmodule OkComputer.PipeMultiChannelWithSingleOperatorTest do
  use OkComputer.PipeOperatorTests
  alias OkComputer.Monad.{Result, Error}

  pipe([{Result, :~>}, {Error, :<~}])

  assert_Result_map()
  assert_Error_map()
end

defmodule OkComputer.PipeMultiChannelWithTwoOperatorsTest do
  use OkComputer.PipeOperatorTests
  alias OkComputer.Monad.{Result, Error}

  pipe([{Result, :~>, :~>>}, {Error, :<~, :<<~}])

  assert_Result_bind()
  assert_Result_map()
  assert_Error_bind()
  assert_Error_map()
end

defmodule OkComputer.PipeMultiChannelTest do
  use OkComputer.PipeOperatorTests
  alias OkComputer.Monad.{Result, Error}

  pipe([
    {Result, [~>: :map]},
    {Error, [<~: :map]}
  ])

  assert_Result_map()
  assert_Error_map()
end

defmodule OkComputer.PipeTest do
  use ExUnit.Case

  test "must provide at least one pipe" do
    source = """
      defmodule BadPipe do
        import OkComputer.PipeOperator
        pipe []
      end
    """

    assert_raise ArgumentError, fn -> Code.eval_string(source) end
  end
end
