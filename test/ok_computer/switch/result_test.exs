defmodule OkComputer.Switch.ResultTest do
  alias OkComputer.Switch.Result

  use ExUnit.Case
  import Result

  doctest Result

  test "~>" do
    assert {:ok, :a} ~> to_string() == {:ok, "a"}
  end

  test "~>>" do
    assert {:ok, %{a: 1}} ~>> Map.fetch(:a) == {:ok, 1}
  end

  test "<~" do
    assert {:error, :a} <~ to_string() == {:error, "a"}
  end

  test "<<~" do
    assert {:error, %{a: 1}} <<~ Map.fetch(:a) == {:ok, 1}
  end
end
