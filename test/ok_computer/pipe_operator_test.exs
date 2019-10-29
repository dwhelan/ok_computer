defmodule OkComputer.PipeOperator.CustomOperatorsTest do
  use ExUnit.Case
  import OkComputer.PipeOperator
  alias OkComputer.Monad.Result

  pipe_operators(Result, ~>: [bind: 2], ~>>: [map: 2])

  test "~> should be Result.bind" do
    f = fn :value -> {:ok, "value"} end

    assert {:ok, :value} ~> f.() == {:ok, "value"}
    assert :anything_else ~> f.() == :anything_else
  end

  test "~>> should be Result.map" do
    f = fn :value -> "value" end

    assert {:ok, :value} ~>> f.() == {:ok, "value"}
    assert :anything_else ~>> f.() == :anything_else
  end
end
