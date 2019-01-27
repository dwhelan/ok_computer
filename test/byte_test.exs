defmodule Byte do
  defmodule Decode do
    def decode <<>> do
      {:error, {:insufficient_bytes, <<>>}}
    end

    def decode <<byte, rest::binary>> do
      {:ok, {byte, rest}}
    end
  end

  defmodule Encode do
    def encode(value) when is_integer(value) and value >= 0 and value <= 255 do
      {:ok, <<value>>}
    end

    def encode value do
      {:error, {:invalid_byte, value}}
    end
  end
end


defmodule Byte.DecodeTest do
  use ExUnit.Case

  import Byte.Decode

  test "decode with no bytes" do
    assert decode(<<>>) == {:error, {:insufficient_bytes, <<>>}}
  end

  test "decode with bytes" do
    assert decode(<<  0, "rest">>) == {:ok, {  0, <<"rest">>}}
    assert decode(<<255, "rest">>) == {:ok, {255, <<"rest">>}}
  end
end

defmodule Byte.EncodeTest do
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
