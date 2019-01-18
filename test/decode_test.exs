defmodule EncodeTest do
  use ExUnit.Case
  import OkError

  use Monad.Laws

  defmodule OkEncoder do
    import OkError

    def encode value do
      ok {"encode(#{value})", "bytes", OkEncoder}
    end
  end

  defmodule ErrorEncoder do
    import OkError

    def encode _value do
      error "encode error"
    end
  end

  test "return" do
    assert Encode.return({:error, "reason"})                == error "reason"
    assert Encode.return({:ok, {"value", <<>>, OkEncoder}}) == ok {"value", <<>>, OkCode}
  end

  describe "bind/2 with" do
    test "an 'ok' from 'map' should encode the mapped value" do
      map = fn {value, bytes, codec} -> ok {"map(#{value})", bytes, codec} end
      assert Encode.bind({:ok, {"value", <<>>, OkEncoder}}, map) == ok {"encode(map(value))", "bytes", OkCode}
    end

    test "an 'ok' from an identity 'map' should encode the original value" do
      map = fn result -> ok result end
      assert Encode.bind({:ok, {"value", <<>>, OkEncoder}}, map) == ok {"encode(value)", "bytes", OkCode}
    end

    test "an 'error' from 'map' should return the map error" do
      map = fn _ -> error "map error" end
      assert Encode.bind({:ok, {"value", <<>>, OkEncoder}}, map) == error "map error"
    end

    test "an 'error' from 'encode' should return the encode error" do
      map = fn result -> ok result end
      assert Encode.bind({:ok, {"value", <<>>, ErrorEncoder}}, map) == error "encode error"
    end

    test "bind error {value, bytes, codec}, f" do
      assert Encode.bind({:error, "reason"}, fn a -> Encode.return "f(#{a})" end) == error "reason"
    end
  end
end
