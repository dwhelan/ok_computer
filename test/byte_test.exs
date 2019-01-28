defmodule Byte do
  defmodule Decode do
    use Codec.Decode

    @spec decode(binary) :: OkError.ok
    def decode <<byte, rest::binary>> do
      ok byte, rest
    end
  end

  defmodule Encode do
    use Codec.Encode

    @spec encode(byte) :: OkError.ok
    def encode(byte) when is_byte(byte) do
      ok <<byte>>
    end

    @spec encode(any) :: OkError.error
    def encode value do
      error :invalid_byte, value
    end
  end
end

defmodule Byte.DecodeTest do
  use DecodeTest

  import Byte.Decode

  test "decode with no bytes" do
    assert decode(<<>>) == error :insufficient_bytes, <<>>
  end

  test "decode with bytes" do
    assert decode(<<0,   "rest">>) == ok 0,   <<"rest">>
    assert decode(<<255, "rest">>) == ok 255, <<"rest">>
  end
end

defmodule Byte.EncodeTest do
  use EncodeTest

  import Byte.Encode

  test "encode with a byte" do
    assert encode(0)   == ok <<0>>
    assert encode(255) == ok <<255>>
  end

  test "encode with a non-byte" do
    assert encode(256) == error :invalid_byte, 256
  end
end
