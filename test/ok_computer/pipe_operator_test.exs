defmodule OkComputer.PipeOperatorTests do
  defmacro assert_Result_bind do
    quote do
      test "~> should be Result.bind" do
        f = fn :value -> {:ok, "value"} end

        assert {:ok, :value} ~> f.() == {:ok, "value"}
        assert :anything_else ~> f.() == :anything_else
      end
    end
  end

  defmacro assert_Result_map do
    quote do
      test "~>> should be Result.map" do
        f = fn :value -> "value" end

        assert {:ok, :value} ~>> f.() == {:ok, "value"}
        assert :anything_else ~>> f.() == :anything_else
      end
    end
  end

  defmacro assert_Error_bind do
    quote do
      test "<~ should be Error.bind" do
        f = fn :reason -> {:error, "reason"} end

        assert {:error, :reason} <~ f.() == {:error, "reason"}
        assert :anything_else <~ f.() == :anything_else
      end
    end
  end

  defmacro assert_Error_map do
    quote do
      test "<<~ should be Error.map" do
        f = fn :reason -> "reason" end

        assert {:error, :reason} <<~ f.() == {:error, "reason"}
        assert :anything_else <<~ f.() == :anything_else
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

defmodule OkComputer.PipeOperator.DefaultOperatorsTest do
  use OkComputer.PipeOperatorTests
  alias OkComputer.Monad.Result

  pipe Result

  assert_Result_bind()
  assert_Result_map()
end

defmodule OkComputer.PipeOperator.CustomOperatorsTest do
  use OkComputer.PipeOperatorTests
  alias OkComputer.Monad.Result

  pipe Result, ~>: :bind, ~>>: :map

  assert_Result_bind()
  assert_Result_map()
end
