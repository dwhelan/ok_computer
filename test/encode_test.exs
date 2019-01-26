defmodule EncodeTest do
  use ExUnit.Case
  import OkError

  use Monad.Laws

  def assert_code_raise error, code do
    ExUnit.Assertions.assert_raise error, fn -> Code.eval_string(code) end
  end

  defmodule OkEncoder do
    import OkError

    def encode _value do
      ok <<"bytes">>
    end
  end

  defmodule ErrorEncoder do
    import OkError

    def encode _value do
      error "encode error"
    end
  end

  describe "map/2 with" do
    test "an ok result should map the value" do
      map = fn value -> String.upcase(value) end
      assert Encode.map({:ok, "value"}, map) == {:ok, "VALUE"}
    end

    test "an ok result with a mapping error should return the error" do
      map = fn _ -> error "map error" end
      assert Encode.map({:ok, "value"}, map) == error "map error"
    end

    test "an ok result with a nil mapping result should return an error" do
      map = fn _ -> nil end
      assert Encode.map({:ok, "value"}, map) == error nil
    end

    test "an error result should return error without mapping" do
      assert Encode.map({:error, "reason"}, fn value -> String.upcase(value) end) == {:error, "reason"}
    end
  end
end
