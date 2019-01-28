defmodule DataTypes do
  defp is_integer? value, min, max do
    quote do
      is_integer(unquote value) and unquote(value) >= unquote(min) and unquote(value) <= unquote(max)
    end
  end

  defmacro is_byte value do
    is_integer? value, 0, 255
  end

  defmacro is_short_length(value) do
    is_integer? value, 0, 30
  end

  def max_long do
    # 30 0xffs
    0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
  end

  def max_long_bytes do
    <<30, max_long()::240>>
  end

  defmacro is_long value do
    is_integer? value, 0, max_long()
  end
end

defmodule Codec.Encode do
  def error code, value do
    OkError.error code: code, value: value
  end

  def error code, bytes, value do
    OkError.error code: code, bytes: bytes, value: value
  end

  defmacro __using__ _ do
    quote do
      import DataTypes
      import OkError
      import Codec.Encode
    end
  end
end

defmodule Codec.Decode do
  def ok value, rest do
    OkError.ok {value, rest}
  end

  def error code, bytes do
    OkError.error code: code, bytes: bytes
  end

  def error code, bytes, value do
    OkError.error code: code, bytes: bytes, value: value
  end

  defmacro __using__ _ do
    quote do
      import DataTypes
      import OkError
      import Codec.Decode

      def decode <<>> do
        error :insufficient_bytes, <<>>
      end
    end
  end
end
