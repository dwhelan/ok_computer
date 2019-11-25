defmodule Lily.PipeTest do
  use ExUnit.Case
  alias Lily.Error
  alias Lily.Pipe
  import Pipe

  describe "pipe/1" do
    test "operator should have arity 2" do
      assert_raise(
        Error,
        ~r/operator with arity 2/,
        fn -> pipe([!: quote(do: fn a -> nil end)], __ENV__) end
      )
    end

    test "pipe function should have arity 2" do
      assert_raise(
        Error,
        ~r/pipe function with arity 2/,
        fn -> pipe([~>: quote(do: fn a -> nil end)], __ENV__) end
      )
    end
  end
end
