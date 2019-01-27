defmodule Byte.Decode do
  use Decode

  def decode <<byte, rest::binary>> do
    {:ok, {byte, rest}}
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
