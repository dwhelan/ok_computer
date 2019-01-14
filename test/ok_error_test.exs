#defmodule OkErrorTest do
#  use ExUnit.Case
#
#  use OkComputer
#
#  test "[v] ~> (f) => ok [f(v)]" do
#    assert ["a", "b"] ~> fn x -> [String.upcase x] end == ok ["A", "B"]
#  end
#
#  test "[v] ~>> (f) => ok [f(v)]" do
#    assert ["a", "b"] ~>> fn x -> [String.upcase x] end == ok ["A", "B"]
#  end
#
#  test "ok(v) ~> (f) => wrap f(v)" do
#    assert ok("") ~> fn _ ->       "called" end == ok "called"
#    assert ok("") ~> fn _ ->    ok "called" end == ok "called"
#    assert ok("") ~> fn _ -> error "called" end == error "called"
#    assert ok("") ~> fn _ ->            nil end == error nil
#    assert ok("") ~> fn _ ->      :error end == error nil
#    assert error("a") ~> fn _ ->    "called" end == error "a"
#  end
#
#  test "ok(v) ~>> (f) => ok(v)" do
#    assert ok("a") ~>> (fn x -> String.upcase x end) == ok "a"
#  end
#
#  test "error(reason) ~>> (f) => wrap_as_error f(reason)" do
#    assert error("a") ~>> fn _ ->       "called" end == error "called"
#    assert error("a") ~>> fn _ ->    ok "called" end == ok "called"
#    assert error("a") ~>> fn _ -> error "called" end == error "called"
#    assert error("a") ~>> fn _ ->       nil end == error nil
#    assert error("a") ~>> fn _ ->    :error end == error nil
#    assert ok("a") ~>> fn _ ->    :error end == ok "a"
#  end
#
#  test "error(reason) ~>> f => error f(reason)" do
#    assert error("r") ~>> fn x -> String.upcase x end == error("R")
#  end
#
#  test "'x ~> f' should be equivalent to 'x ~> (f)'" do
#    assert ok("a") ~> fn _ -> "called" end == ok "called"
#  end
#
#  test "'x ~>> f' should be equivalent to 'x ~>> (f)'" do
#    assert error("a") ~>> fn _ -> "called" end == error "called"
#  end
#
#  test "x <<< f should catch errors'" do
#    assert ok("a") <<< fn _ -> raise "error" end == error {:error, %RuntimeError{message: "error"}}
#  end
#end
