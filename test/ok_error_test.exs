defmodule OkErrorTest do
  use ExUnit.Case
  import OkComputerTest
  import OkError
  import OkError.Operators

  use Monad.Laws

  test "ok" do
    assert ok "a" == {:ok, "a"}
  end

  test "error" do
    assert error "a" == {:error, "a"}
    assert error()   == {:error, nil}
  end

  test "return" do
    assert return(nil)           == {:error, nil}
    assert return({:error, "a"}) == {:error, "a"}
    assert return({:ok, "a"})    == {:ok, "a"}
    assert return("a")           == {:ok, "a"}
  end

  test "return_error" do
    assert return_error(nil)           == {:error, nil}
    assert return_error({:error, "a"}) == {:error, "a"}
    assert return_error("a")           == {:error, "a"}
    assert return_error({:ok, "a"})    == {:ok, "a"}
  end

  test "bind" do
    assert bind({:ok, "a"},    fn a -> ok "f(#{a})" end)    == {:ok, "f(a)"}
    assert bind({:error, "a"}, fn a -> error "f(#{a})" end) == {:error, "a"}
  end

  test "bind_error" do
    assert bind_error({:ok, "a"},    fn a -> ok "f(#{a})" end)    == {:ok, "a"}
    assert bind_error({:error, "a"}, fn a -> error "f(#{a})" end) == {:error, "f(a)"}
  end

  describe "bind_first" do
    test "with single ok should return its result" do
      assert bind_first("a", [fn _ -> ok "A" end]) == {:ok, "A"}
    end

    test "with multiple oks should return first ok" do
      assert bind_first("a", [fn _ -> ok "A" end, fn _ -> ok "B" end]) == {:ok, "A"}
    end

    test "with single error should return its result" do
      assert bind_first("a", [fn _ -> error "A" end]) == {:error, "A"}
    end

    test "with multiple errors should return last error" do
      assert bind_first("a", [fn _ -> error "A" end, fn _ -> error "B" end]) == {:error, "B"}
    end

    test "with ok and error should return ok result" do
      assert bind_first("a", [fn _ -> ok "A" end, fn _ -> error "A" end]) == {:ok, "A"}
    end

    test "with error and ok should return ok result" do
      assert bind_first("a", [fn _ -> error "A" end, fn _ -> ok "A" end]) == {:ok, "A"}
    end
  end

  def upcase a do
    String.upcase(a)
  end

  def ok_upcase a do
    ok String.upcase(a)
  end

  def error_upcase a do
    error String.upcase(a)
  end

  describe "~>> should" do
    test "pipe errors to anonymous functions" do
      assert error("a") ~>> fn a -> ok    String.upcase(a) end == ok "A"
      assert error("a") ~>> fn a -> error String.upcase(a) end == error "A"
      assert error("a") ~>> fn a ->       String.upcase(a) end == error "A"
    end

    test "pipe errors to captured functions" do
      assert error("a") ~>> (&ok_upcase/1)    == ok "A"
      assert error("a") ~>> (&error_upcase/1) == error "A"
      assert error("a") ~>> (&upcase/1)       == error "A"
    end

    test "pipe errors to local function" do
      assert error("a") ~>> ok_upcase    == ok "A"
      assert error("a") ~>> error_upcase == error "A"
      assert error("a") ~>> upcase       == error "A"
    end

    test "pipe errors to qualified functions" do
      assert error("a") ~>> __MODULE__.error_upcase == error "A"
    end

    test "not pipe oks" do
      assert ok("a") ~>> fn a -> String.upcase(a) end == ok "a"
      assert ok("a") ~>> __MODULE__.ok_upcase         == ok "a"
      assert ok("a") ~>> upcase                       == ok "a"
    end

    test "not compile with a variable references" do
      assert_code_raise CompileError, ~s[error("a") ~>> f == error "A"]
    end

    test "not compile with a call to an anonymous function" do
      assert_code_raise CompileError, ~s[error("a") ~>> (fn a -> error String.upcase(a) end).()]
    end
  end
end
