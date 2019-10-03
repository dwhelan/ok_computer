defmodule OkComputer.Monad.OkTupleTest do
  use ExUnit.Case
  import Monad.Laws
  alias OkComputer.Monad.OkTuple
  import OkTuple

  test "return" do
    assert return(:a) == {:ok, :a}
  end

  test "bind" do
    f = fn a -> {:ok, to_string(a)} end

    assert bind({:error, :a}, f) == {:error, :a}
    assert bind(nil, f) == nil
    assert bind({:ok, :a}, f) == {:ok, "a"}
  end

  test "wrap" do
    assert wrap({:ok, :value}) == {:ok, :value}
    assert wrap({:error, :reason}) == {:error, :reason}
    assert wrap(nil) == {:error, nil}
    assert wrap(:value) == {:ok, :value}
  end

  test_monad(OkTuple, :a)
end

defmodule OkComputer.Monad.ErrorTupleTest do
  use ExUnit.Case
  import Monad.Laws
  alias OkComputer.Monad.ErrorTuple
  import ErrorTuple

  test "return" do
    assert return(:a) == {:error, :a}
  end

  test "bind" do
    f = fn a -> {:error, to_string(a)} end

    assert bind({:error, :a}, f) == {:error, "a"}
    assert bind(nil, f) == nil
    assert bind({:ok, :a}, f) == {:ok, :a}
  end

  test_monad(ErrorTuple, :a)
end
