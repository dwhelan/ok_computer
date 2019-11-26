defmodule Lily.PipeTest do
  use ExUnit.Case
  alias Lily.Error
  alias Lily.Pipe
  import Pipe

  describe "pipe/1" do
    test "unary operator" do
      assert_raise(
        Error,
        ~r/expected a binary operator with left to right associativity/,
        fn -> pipe([!: quote(do: fn _a, _f -> nil end)], __ENV__) end
      )
    end

    test "binary operator with incorrect associativity" do
      assert_raise(
        Error,
        ~r/expected a binary operator with left to right associativity/,
        fn -> pipe([<>: quote(do: fn _a, _f -> nil end)], __ENV__) end
      )
    end

    test "pipe function that does not have arity 2" do
      assert_raise(
        Error,
        ~r/expected a pipe function with arity 2/,
        fn -> pipe([~>: quote(do: fn a -> nil end)], __ENV__) end
      )
    end
  end
end
