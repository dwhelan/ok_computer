defmodule Long do
  @moduledoc """
    Specification: WAP-230-WSP-20010705-a, 8.4.2.1 Basic rules

    Long-integer = Short-length Multi-octet-integer
    The Short-length indicates the length of the Multi-octet-integer

    Multi-octet-integer = 1*30 OCTET
    The content octets shall be an unsigned integer value with the most significant octet
    encoded first (big-endian representation).
    The minimum number of octets must be used to encode the value.
  """

  defmodule Decode do
    use Codec.Decode

    def decode bytes do
      bytes |> ShortLength.Decode.decode |> bind(&check_length/1) |> bind(&to_unsigned/1)
    end

    defp check_length {0, bytes} do
      error :long_must_have_at_least_one_data_byte, <<0>> <> bytes, 0
    end

    defp check_length {length, bytes} do
      ok length, bytes
    end

    defp to_unsigned {length, bytes} do
      bytes |> String.split_at(length) |> decode_long
    end

    defp decode_long {long_bytes, rest} do
      ok :binary.decode_unsigned(long_bytes), rest
    end
  end

  defmodule Encode do
    use Codec.Encode

    def encode(value) when is_long(value) do
      value |> :binary.encode_unsigned |> ShortLength.Encode.prepend
    end

    def encode value do
      error :invalid_long, value
    end
  end
end

defmodule Long.DecodeTest do
  use DecodeTest

  import Long.Decode

  test "decode with no bytes" do
    assert decode(<<>>) == error :insufficient_bytes, <<>>
  end

  test "decode with insufficient bytes" do
    assert decode(<<1>>) == error :insufficient_bytes_for_short_length, <<1>>, 1
  end

  test "decode with a length of 0 bytes" do
    assert decode(<<0>>) == error :long_must_have_at_least_one_data_byte, <<0>>, 0
  end

  test "decode a one byte long" do
    assert decode(<< 1, 0,   "rest">>) == ok 0,   <<"rest">>
    assert decode(<< 1, 255, "rest">>) == ok 255, <<"rest">>
  end

  test "decode a two byte long" do
    assert decode(<< 2, 1,   0,   "rest">>) == ok 256,    <<"rest">>
    assert decode(<< 2, 255, 255, "rest">>) == ok 65_535, <<"rest">>
  end

  test "decode max long" do
    assert decode(max_long_bytes() <> "rest") == ok max_long(), <<"rest">>
  end
end

defmodule Long.EncodeTest do
  use EncodeTest

  import Long.Encode

  test "encode a one byte long" do
    assert encode(0)   == ok <<1, 0>>
    assert encode(255) == ok <<1, 255>>
  end

  test "encode a two byte long" do
    assert encode(256)    == ok <<2, 1,   0>>
    assert encode(65_535) == ok <<2, 255, 255>>
  end

  test "encode max long" do
    assert encode(max_long()) == ok max_long_bytes()
  end

  test "encode value out of range" do
    assert encode(-1)           == error :invalid_long, -1
    assert encode(max_long()+1) == error :invalid_long, max_long()+1
  end
end
