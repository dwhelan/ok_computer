defmodule OkErrorTest do
  use ExUnit.Case

  use OkComputer

  test "[v] ~> (f) => ok [f(v)]" do
    assert ["a", "b"] ~> fn x -> [String.upcase x] end == ok ["A", "B"]
  end

  test "[v] ~>> (f) => ok [f(v)]" do
    assert ["a", "b"] ~>> fn x -> [String.upcase x] end == ok ["A", "B"]
  end

  test "ok(v) ~> (f) => wrap f(v)" do
    assert ok("v") ~> fn _ ->       "V" end == ok "V"
    assert ok("v") ~> fn _ ->    ok "V" end == ok "V"
    assert ok("v") ~> fn _ -> error "V" end == error "V"
    assert ok("v") ~> fn _ ->       nil end == error nil
    assert ok("v") ~> fn _ ->    :error end == error nil
  end

  test "ok(v) ~>> (f) => ok(v)" do
    assert ok("v") ~>> (fn x -> String.upcase x end) == ok "v"
  end

  test "error(reason) ~>> (f) => wrap_as_error f(reason)" do
    assert error("v") ~>> fn _ ->       "V" end == error "V"
    assert error("v") ~>> fn _ ->    ok "V" end == ok "V"
    assert error("v") ~>> fn _ -> error "V" end == error "V"
    assert error("v") ~>> fn _ ->       nil end == error nil
    assert error("v") ~>> fn _ ->    :error end == error nil
  end

  test "error(reason) ~>> (f) => error f(reason)" do
    assert error("r") ~>> (fn x -> String.upcase x end) == error("R")
  end

  test "'x ~> f' should be equivalent to 'x ~> (f)'" do
    assert ok("v") ~> fn _ -> "V" end == ok "V"
  end

  test "'x ~>> f' should be equivalent to 'x ~>> (f)'" do
    assert error("v") ~>> fn _ -> "V" end == error "V"
  end
end
