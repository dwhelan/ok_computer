defmodule Monad.OperatorsTest do
  use ExUnit.Case
  import OkComputerTest

  import OkError
  import Monad.Operators

  def upcase a do
    String.upcase(a)
  end

  def ok_upcase a do
    ok String.upcase(a)
  end

  def error_upcase a do
    error String.upcase(a)
  end

  describe "~> should" do
    test "pipe oks to anonymous functions" do
      assert ok("a") ~> fn a -> error String.upcase(a) end == error "A"
      assert ok("a") ~> fn a -> ok    String.upcase(a) end == ok "A"
      assert ok("a") ~> fn a ->       String.upcase(a) end == ok "A"
    end

    test "pipe oks to captured functions" do
      assert ok("a") ~> (&error_upcase/1) == error "A"
      assert ok("a") ~> (&ok_upcase/1)    == ok "A"
      assert ok("a") ~> (&upcase/1)       == ok "A"
    end

    test "pipe oks to local function" do
      assert ok("a") ~> error_upcase == error "A"
      assert ok("a") ~> ok_upcase    == ok "A"
      assert ok("a") ~> upcase       == ok "A"
    end

    test "pipe oks to qualified functions" do
      assert ok("a") ~> __MODULE__.ok_upcase == ok "A"
    end

    test "not pipe errors" do
      assert error("a") ~> fn a -> String.upcase(a) end == error "a"
      assert error("a") ~> __MODULE__.ok_upcase         == error "a"
      assert error("a") ~> upcase                       == error "a"
    end

    test "not compile with a variable references" do
      assert_code_raise CompileError, ~s[ok("a") ~> f == ok "A"]
    end

    test "not compile with a call to an anonymous function" do
      assert_code_raise CompileError, ~s[ok("a") ~> (fn a -> ok String.upcase(a) end).()]
    end
  end
end
