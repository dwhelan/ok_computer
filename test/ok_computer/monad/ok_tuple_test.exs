defmodule OkComputer.Monad.OkTupleTest do
  use ExUnit.Case
  import Monad.Laws
  alias OkComputer.Monad.OkTuple
  import OkTuple

  test "return" do
    assert return({:ok, :a}) == {:ok, :a}
    assert return({:error, :a}) == {:error, :a}
    assert return(nil) == {:error, nil}
    assert return(:a) == {:ok, :a}
  end

  @tag :skip
  test "bind" do
    assert bind(nil, &to_string/1) == nil
    assert bind(false, &to_string/1) == false
    assert bind(:anything_else, &to_string/1) == "anything_else"
  end

#  test_monad(OkTuple, {":ok, a"})
end

defmodule OkComputer.Monad.ErrorTupleTest do
  use ExUnit.Case
  import Monad.Laws
  alias OkComputer.Monad.ErrorTuple
  import ErrorTuple

  test "return" do
    assert return({:ok, :a}) == {:ok, :a}
    assert return({:error, :a}) == {:error, :a}
    assert return(nil) == {:error, nil}
    assert return(:a) == {:error, :a}
  end

  @tag :skip
  test "bind" do
    assert bind(nil, &to_string/1) == nil
    assert bind(false, &to_string/1) == false
    assert bind(:anything_else, &to_string/1) == "anything_else"
  end

#  test_monad(OkTuple, :anything_truthy)
end
