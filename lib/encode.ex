defmodule DataTypes do
  defp is_integer? value, min, max do
    quote do
      is_integer(unquote value) and unquote(value) >= unquote(min) and unquote(value) <= unquote(max)
    end
  end

  defmacro is_short_length value do
    is_integer? value, 1, 30
  end

  def max_long do
    # 30 0xffs
    0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
  end

  defmacro is_long value do
    is_integer? value, 0, max_long()
  end
end

defmodule Codec do
  defmodule Encode do
    def ok value do
      OkError.ok value
    end

    def error reason, value do
      OkError.error {reason, value}
    end

    #  def map({:error, reason}, _) do
    #    {:error, reason}
    #  end
    #
    #  def map({:ok, value}, f) when is_function(f) do
    #    value |> f.() |> return
    #  end
    defmacro __using__ _ do
      quote do
        import DataTypes
        import Encode
      end
    end
  end

  defmodule Decode do
    def ok value, rest do
      OkError.ok {value, rest}
    end

    def error reason, value do
      OkError.error {reason, value}
    end

    defmacro __using__ _ do
      quote do
        import DataTypes
        import Decode

        def decode <<>> do
          {:error, {:insufficient_bytes, <<>>}}
        end
      end
    end
  end
end

