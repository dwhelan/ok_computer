defmodule ShortLength do

  defmodule Decode do
    use Codec.Decode

    def decode(<<value, rest::binary>>) when is_short_length(value) do
      ok value, rest
    end

    def decode <<value, _rest::binary>> do
      error {:invalid_short_length, <<value>>}
    end
  end

  defmodule Encode do
    use Codec.Encode

    def encode(value) when is_short_length(value) do
      ok <<value>>
    end

    def encode value do
      {:error, {:invalid_short_length, value}}
    end
  end
end

defmodule ShortLength.DecodeTest do
  use ExUnit.Case

  import ShortLength.Decode

  test "decode with no bytes" do
    assert decode(<<>>) == {:error, {:insufficient_bytes, <<>>}}
  end

  test "decode a short length" do
    assert decode(<< 1, "rest">>) == {:ok, { 1, "rest"}}
    assert decode(<<30, "rest">>) == {:ok, {30, "rest"}}
  end

  test "decode a non short length" do
    assert decode(<< 0, "rest">>) == {:error, {:invalid_short_length, << 0>>}}
    assert decode(<<31, "rest">>) == {:error, {:invalid_short_length, <<31>>}}
  end
end

defmodule ShortLength.EncodeTest do
  use ExUnit.Case

  import ShortLength.Encode

  test "encode a short length" do
    assert encode(1)  == {:ok, <<1>>}
    assert encode(30) == {:ok, <<30>>}
  end

  test "encode a non short length" do
    assert encode(0)  == {:error, {:invalid_short_length, 0}}
    assert encode(31) == {:error, {:invalid_short_length, 31}}
  end
end
