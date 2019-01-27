defmodule Byte.Decode do
  use Decode

  def decode <<byte, rest::binary>> do
    {:ok, {byte, rest}}
  end

end

defmodule Byte.Encode do
  def encode(value) when is_integer(value) and value >= 0 and value <= 255 do
    {:ok, <<value>>}
  end

  def encode value do
    {:error, {:invalid_byte, value}}
  end
end

defmodule Byte.DecodeTest do
  use ExUnit.Case

  import Byte.Decode

  test "decode when no bytes" do
    assert decode(<<>>) == {:error, :insufficient_bytes}
  end

  test "decode when bytes available" do
    assert decode(<<42>>) == {:ok, {42, <<>>}}
  end
end

defmodule Byte.EncodeTest do
  use ExUnit.Case

  import Byte.Encode

  test "encode with a byte value" do
    assert encode(42) == {:ok, <<42>>}
  end

  test "encode with a non-byte value" do
    assert encode(256) == {:error, {:invalid_byte, 256}}
  end
end