defmodule OkErrorTest do
  use ExUnit.Case
  import OkError

  use Monad.Laws

  test "return" do
    assert return(nil)           == {:error, nil}
    assert return({:error, "a"}) == {:error, "a"}
    assert return({:ok, "a"})    == {:ok, "a"}
    assert return("a")           == {:ok, "a"}
  end

  test "bind" do
    assert bind({:ok, "a"},    fn a -> ok "f(#{a})" end) == {:ok, "f(a)"}
    assert bind({:error, "a"}, fn a -> ok "f(#{a})" end) == {:error, "a"}
  end

  test "ok" do
    assert ok "a" == {:ok, "a"}
  end

  test "error" do
    assert error "a" == {:error, "a"}
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
end
