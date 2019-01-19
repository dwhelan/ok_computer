defmodule EncodeTest do
  use ExUnit.Case
  import OkError

  use Monad.Laws

  defmodule OkEncoder do
    import OkError

    def encode value do
      ok {"encode(#{value})", <<"bytes">>, __MODULE__}
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
      assert Encode.return({:ok, {"value", <<>>, OkEncoder}}) == ok {"value", <<>>, OkEncoder}
    end
  end

  describe "bind/2 with" do
    test "an 'ok' from 'map' should encode the mapped value" do
      map = fn {value, bytes, codec} -> ok {"map(#{value})", bytes, codec} end
      assert Encode.bind({:ok, {"value", <<>>, OkEncoder}}, map) == ok {"encode(map(value))", <<"bytes">>, OkEncoder}
    end

    test "an input 'error' should return the input error" do
      map = fn result -> ok result end
      assert Encode.bind({:error, "reason"}, map) == error "reason"
    end

    test "an 'error' from 'map' should return the map error" do
      map = fn _ -> error "map error" end
      assert Encode.bind({:ok, {"value", <<>>, OkEncoder}}, map) == error "map error"
    end

    test "an 'error' from 'encode' should return the encode error" do
      map = fn result -> ok result end
      assert Encode.bind({:ok, {"value", <<>>, ErrorEncoder}}, map) == error "encode error"
    end
  end

  describe "ok/1 with" do
    def assert_code_raise error, code do
      ExUnit.Assertions.assert_raise error, fn -> Code.eval_string(code) end
    end

    test "a valid result should return the result in an ok tuple" do
      assert Encode.ok({"value", <<>>, OkEncoder}) == {:ok, {"value", <<>>, OkEncoder}}
    end

    test "non-binary bytes should raise a FunctionClauseError" do
      assert_code_raise FunctionClauseError, ~s(Encode.ok {"value", :not_binary, OkEncoder})
    end

    test "a non-atom codec should raise a FunctionClauseError" do
      assert_code_raise FunctionClauseError, ~s(Encode.ok {"value", <<>>, "not_a_module"})
    end
  end
end
