defmodule EncodeTest do
  use ExUnit.Case

  import Encode

#  use Monad.Laws

  defmodule TestCodec do
    import OkError

    def encode value do
      ok value
    end
  end

  test "return" do
    assert return({:error, "reason"})                == {:error, "reason"}
    assert return({:ok, {"value", TestCodec, <<>>}}) == {:ok, {"value", TestCodec, <<>>}}
  end

  test "bind" do
    assert bind({:error, "reason"}, fn a -> return "f(#{a})" end) == {:error, "reason"}
#    assert bind({:ok, {"value", TestCodec}},    fn a -> return "f(#{a})" end) == {:ok, {"f(value)"}}
  end

#  test "ok" do
#    assert ok "a" == {:ok, "a"}
#  end
#
#  test "error" do
#    assert error "a" == {:error, "a"}
#  end
end
