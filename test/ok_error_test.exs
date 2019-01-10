defmodule OkErrorTest do
  use ExUnit.Case

  use OkComputer

  test "[v] |> when_ok(f) => ok [f(v)]" do
    assert ["a", "b"] |> when_ok(fn x -> [String.upcase x] end) == ok ["A", "B"]
  end

  test "[v] |> when_error(f) => ok [f(v)]" do
    assert ["a", "b"] |> when_error(fn x -> [String.upcase x] end) == ok ["A", "B"]
  end

  test "ok(v) |> when_ok(f) => wrap f(v)" do
    assert ok("v") |> when_ok(fn _ ->       "V" end) == ok "V"
    assert ok("v") |> when_ok(fn _ ->    ok "V" end) == ok "V"
    assert ok("v") |> when_ok(fn _ -> error "V" end) == error "V"
    assert ok("v") |> when_ok(fn _ ->       nil end) == error nil
    assert ok("v") |> when_ok(fn _ ->    :error end) == error nil
  end

  test "ok(v) |> when_error(f) => ok(v)" do
    assert ok("v") |> when_error(fn x -> String.upcase x end) == ok "v"
  end

  test "error(reason) |> when_error(f) => wrap_as_error f(reason)" do
    assert error("v") |> when_error(fn _ ->       "V" end) == error "V"
    assert error("v") |> when_error(fn _ ->    ok "V" end) == ok "V"
    assert error("v") |> when_error(fn _ -> error "V" end) == error "V"
    assert error("v") |> when_error(fn _ ->       nil end) == error nil
    assert error("v") |> when_error(fn _ ->    :error end) == error nil
  end

  test "error(reason) |> when_error(f) => error f(reason)" do
    assert error("r") |> when_error(fn x -> String.upcase x end) == error("R")
  end

  test "'x ~> f' should be equivalent to 'x |> when_ok(f)'" do
    assert ok("v") ~> fn _ -> "V" end == ok "V"
  end

  test "'x ~>> f' should be equivalent to 'x |> when_error(f)'" do
    assert error("v") ~>> fn _ -> "V" end == error "V"
  end
end
