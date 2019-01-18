defmodule EncodeTest do
  use ExUnit.Case
  import OkError

  use Monad.Laws

  defmodule TestCodec do
    import OkError

    def encode value do
      ok {"encode(#{value})", "bytes", TestCodec}
    end
  end

  test "return" do
    assert Encode.return({:error, "reason"})                == error "reason"
    assert Encode.return({:ok, {"value", <<>>, TestCodec}}) == ok {"value", <<>>, TestCodec}
  end

  describe "bind/2 with" do
    test "an 'ok' result from 'map' should encode the mapped value" do
      map = fn {value, bytes, codec} -> ok {"f(#{value})", bytes, codec} end
      assert Encode.bind({:ok, {"value", <<>>, TestCodec}}, map) == ok {"encode(f(value))", "bytes", TestCodec}
    end

    test "an 'ok' result from an identity 'map' should encode the original value" do
      map = fn result -> ok result end
      assert Encode.bind({:ok, {"value", <<>>, TestCodec}}, map) == ok {"encode(value)", "bytes", TestCodec}
    end

    test "an 'error' result from 'map' should return the error" do
      map = fn result -> error "reason" end
      assert Encode.bind({:ok, {"value", <<>>, TestCodec}}, map) == error "reason"
    end

    test "bind error {value, bytes, codec}, f" do
      assert Encode.bind({:error, "reason"}, fn a -> Encode.return "f(#{a})" end) == error "reason"
    end
  end
end
