defmodule OperatorsTest do
  use ExUnit.Case
  import OkComputerTest

  import OkError
  import Operators

  describe "~> should" do
    def upcase a do
      String.upcase(a)
    end

    def ok_upcase a do
      ok String.upcase(a)
    end

    test "pipe to anonymous function" do
      assert ok("a") ~> fn a -> ok String.upcase(a) end == ok "A"
      assert ok("a") ~> fn a ->    String.upcase(a) end == ok "A"
    end

    test "pipe to captured function" do
      assert ok("a") ~> (&ok_upcase/1) == ok "A"
      assert ok("a") ~> (&upcase/1)    == ok "A"
    end

    test "pipe to local function" do
      assert ok("a") ~> ok_upcase == ok "A"
      assert ok("a") ~> upcase    == ok "A"
    end

    test "pipe to module function" do
      assert ok("a") ~> __MODULE__.ok_upcase == ok "A"
    end

    test "not compile with a variable references" do
      assert_code_raise CompileError, ~s[ok("a") ~> f == ok "A"]
    end

    test "not compile with a call to an anonymous function" do
      assert_code_raise CompileError, ~s[ok("a") ~> (fn a -> ok String.upcase(a) end).()]
    end
  end
end
