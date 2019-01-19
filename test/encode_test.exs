defmodule EncodeTest do
  use ExUnit.Case
  import OkError

  use Monad.Laws

  def assert_code_raise error, code do
    ExUnit.Assertions.assert_raise error, fn -> Code.eval_string(code) end
  end

  defmodule OkEncoder do
    import OkError

    def encode value do
      ok {<<"bytes">>, __MODULE__, "encode(#{value})"}
    end
  end

  defmodule ErrorEncoder do
    import OkError

    def encode _value do
      error "encode error"
    end
  end

  describe "return/1 with" do
    test "an error" do
      assert Encode.return({:error, "reason"}) == error "reason"
    end

    test "an ok" do
      assert Encode.return({:ok, {<<>>, OkEncoder, "value"}}) == ok {<<>>, OkEncoder, "value"}
    end
  end

  describe "bind/2 with" do
    test "an 'ok' from 'map' should encode the mapped value" do
      map = fn {bytes, codec, value} -> ok {bytes, codec, "map(#{value})"} end
      assert Encode.bind({:ok, {<<>>, OkEncoder, "value"}}, map) == ok {<<"bytes">>, OkEncoder, "encode(map(value))"}
    end

    test "an input 'error' should return the input error" do
      map = fn result -> ok result end
      assert Encode.bind({:error, "reason"}, map) == error "reason"
    end

    test "an 'error' from 'map' should return the map error" do
      map = fn _ -> error "map error" end
      assert Encode.bind({:ok, {<<>>, OkEncoder, "value"}}, map) == error "map error"
    end

    test "an 'error' from 'encode' should return the encode error" do
      map = fn result -> ok result end
      assert Encode.bind({:ok, {<<>>, ErrorEncoder, "value"}}, map) == error "encode error"
    end
  end

  describe "ok/1 with" do
    test "a valid result should return the result in an ok tuple" do
      assert Encode.ok({<<>>, OkEncoder, "value"}) == {:ok, {<<>>, OkEncoder, "value"}}
    end

    test "non-binary bytes should raise a FunctionClauseError" do
      assert_code_raise FunctionClauseError, ~s(Encode.ok {:not_binary, OkEncoder, "value"})
    end

    test "a non-atom codec should raise a FunctionClauseError" do
      assert_code_raise FunctionClauseError, ~s(Encode.ok {<<>>, "not_a_module", "value"})
    end
  end
end
