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

    def decode(<<length, bytes::binary>>) when is_short_length(length) and length <= byte_size(bytes) do
      {value_bytes, rest} = String.split_at bytes, length
      ok {:binary.decode_unsigned(value_bytes), rest}
    end
  end

  defmodule Encode do
    use Codec.Encode

    def encode(value) when is_long(value) do
      bytes = :binary.encode_unsigned value
      ok <<byte_size(bytes)>> <> bytes
    end

    def encode value do
      {:error, {:invalid_byte, value}}
    end
  end
end

#
#      examples: [
#        { << l(1), 0 >>,        0      },
#        { << l(1), 255 >>,      255    },
#        { << l(2), 1,   0 >>,   256    },
#        { << l(2), 255, 255 >>, 65_535 },
#
#        { max_long_bytes(), max_long() }
#      ],
#
#      decode_errors: [
#        { <<0>>,  :invalid_long },
#        { <<1>>,  :invalid_long },
#        { <<31>>, :invalid_long },
#      ],
#
#      encode_errors: [
#        { -1,              :invalid_long },
#        { max_long()+1,    :invalid_long },
#        { :not_an_integer, :invalid_long },
#      ]
#
defmodule Long.DecodeTest do
  use ExUnit.Case

  import Long.Decode

  test "decode with no bytes" do
    assert decode(<<>>) == {:error, {:insufficient_bytes, <<>>}}
  end

  test "decode a long with one data byte" do
    assert decode(<< 1, 0, "rest">>) == {:ok, {0, <<"rest">>}}
    assert decode(<< 1, 255, "rest">>) == {:ok, {255, <<"rest">>}}
  end

  test "decode a long with two data bytes" do
    assert decode(<< 2,   1,   0, "rest">>) == {:ok, {   256, <<"rest">>}}
    assert decode(<< 2, 255, 255, "rest">>) == {:ok, {65_535, <<"rest">>}}
  end
end

defmodule Long.EncodeTest do
  use ExUnit.Case

  import Byte.Encode

  test "encode with a byte value" do
    assert encode(0)   == {:ok, <<0>>}
    assert encode(255) == {:ok, <<255>>}
  end

  test "encode with a non-byte value" do
    assert encode(256) == {:error, {:invalid_byte, 256}}
  end
end
