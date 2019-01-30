defmodule OkErrorTest do
  use ExUnit.Case
  import OkComputerTest
  import OkError

  use Monad.Laws

  test "return" do
    assert return(nil)           == {:error, nil}
    assert return({:ok, "a"})    == {:ok, "a"}
    assert return({:error, "a"}) == {:error, "a"}
    assert return("a")           == {:ok, "a"}
  end

  test "bind" do
    assert bind({:ok, "a"},    fn a -> return "f(#{a})" end) == {:ok, "f(a)"}
    assert bind({:error, "a"}, fn a -> return "f(#{a})" end) == {:error, "a"}
  end

  test "ok" do
    assert ok "a" == {:ok, "a"}
  end

  test "error" do
    assert error "a" == {:error, "a"}
  end


  describe "~> operator" do
    def upcase a do
      String.upcase(a)
    end

    def ok_upcase a do
      ok String.upcase(a)
    end

    test "anonymous function" do
      assert ok("a") ~> fn a -> ok String.upcase(a) end == ok "A"
      assert ok("a") ~> fn a ->    String.upcase(a) end == ok "A"
    end

    test "captured function" do
      assert ok("a") ~> (&ok_upcase/1) == ok "A"
      assert ok("a") ~> (&upcase/1)    == ok "A"
    end

    test "local function" do
      assert ok("a") ~> ok_upcase == ok "A"
      assert ok("a") ~> upcase    == ok "A"
    end

    test "module function" do
      assert ok("a") ~> __MODULE__.ok_upcase == ok "A"
    end

    test "anonymous function call" do
      assert_code_raise CompileError, ~s[ok("a") ~> f == ok "A"]
    end

    test "called anonymous function" do
      assert_code_raise CompileError, ~s[ok("a") ~> (fn a -> ok String.upcase(a) end).()]
    end
  end
end
