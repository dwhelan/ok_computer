defmodule ShortLength do

  defmodule Decode do
    use Codec.Decode

    def decode(<<length, rest::binary>>) when is_short_length(length) and length <= byte_size(rest) do
      ok length, rest
    end

    def decode(bytes = <<length, _::binary>>) when is_short_length(length) do
      error :insufficient_bytes_for_short_length, bytes, length
    end

    def decode bytes = <<length, _::binary>> do
      error :invalid_short_length, bytes, length
    end
  end

  defmodule Encode do
    use Codec.Encode

    def encode(length) when is_short_length(length) do
      ok <<length>>
    end

    def encode length do
      error :invalid_short_length, length
    end

    def prepend(bytes) when is_binary(bytes) and is_short_length(byte_size bytes) do
      ok <<byte_size(bytes)>> <> bytes
    end

    def prepend(bytes) when is_binary(bytes) do
      error :short_length_cannot_exceed_30_bytes, bytes, byte_size(bytes)
    end
  end
end

defmodule ShortLength.DecodeTest do
  use DecodeTest

  import ShortLength.Decode

  test "decode with no bytes" do
    assert decode(<<>>) == error :insufficient_bytes, <<>>
  end

  @thirty_chars String.duplicate("a", 30)

  test "decode a short length with sufficient bytes" do
    assert decode(<<0,  "rest">>)        == ok 0,  "rest"
    assert decode(<<30, @thirty_chars>>) == ok 30, @thirty_chars
  end

  test "decode a short length with insufficient bytes" do
    assert decode(<<5, "rest">>) == error :insufficient_bytes_for_short_length, <<5, "rest">>, 5
  end

  test "decode a non short length" do
    assert decode(<<31, "rest">>) == error :invalid_short_length, <<31, "rest">>, 31
  end
end

defmodule ShortLength.EncodeTest do
  use EncodeTest

  import ShortLength.Encode

  test "encode a short length" do
    assert encode(1)  == ok <<1>>
    assert encode(30) == ok <<30>>
  end

  test "encode a non short length" do
    assert encode(31) == error :invalid_short_length, 31
  end

  describe "prepend" do
    @thirty_chars String.duplicate("a", 30)

    test "with valid values" do
      assert prepend("")            == ok <<0>>
      assert prepend("a")           == ok <<1, "a">>
      assert prepend(@thirty_chars) == ok <<30>> <> @thirty_chars
    end

    @thirty_one_chars String.duplicate("a", 31)

    test "with too many bytes" do
      assert prepend(@thirty_one_chars) == error :short_length_cannot_exceed_30_bytes, @thirty_one_chars, 31
    end
  end
end
