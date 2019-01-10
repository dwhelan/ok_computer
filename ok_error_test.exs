defmodule OkErrorTest do
  use ExUnit.Case

  use Towel
  import OkError
  import OkError.Operators

  test "[v] |> when_ok(f) => ok [f(v)]" do
    assert ["a", "b"] |> when_ok(fn x -> [String.upcase x] end) == ok ["A", "B"]
  end

  test "[v] |> when_error(f) => ok [f(v)]" do
    assert ["a", "b"] |> when_error(fn x -> [String.upcase x] end) == ok ["A", "B"]
  end

  test "ok(v) |> when_ok(f) => wrap f(v)" do
    assert ok("a") |> when_ok(fn _ ->       "A" end) == ok "A"
    assert ok("a") |> when_ok(fn _ ->    ok "A" end) == ok "A"
    assert ok("a") |> when_ok(fn _ -> error "A" end) == error "A"
    assert ok("a") |> when_ok(fn _ ->       nil end) == error nil
    assert ok("a") |> when_ok(fn _ ->    :error end) == error nil
  end

  test "ok(v) |> when_error(f) => ok(v)" do
    assert ok("a") |> when_error(fn x -> String.upcase x end) == ok "a"
  end

  test "error(reason) |> when_error(f) => wrap_as_error f(reason)" do
    assert error("a") |> when_error(fn _ ->       "A" end) == error "A"
    assert error("a") |> when_error(fn _ ->    ok "A" end) == ok "A"
    assert error("a") |> when_error(fn _ -> error "A" end) == error "A"
    assert error("a") |> when_error(fn _ ->       nil end) == error nil
    assert error("a") |> when_error(fn _ ->    :error end) == error nil
  end

  test "error(reason) |> when_error(f) => error f(reason)" do
    assert error("r") |> when_error(fn x -> String.upcase x end) == error("R")
  end

  test "'x ~> f' should be equivalent to 'x |> when_ok(f)'" do
    assert ok("a") ~> fn _ -> "A" end == ok "A"
  end

  test "'x ~>> f' should be equivalent to 'x |> when_ok(f)'" do
    assert error("a") ~>> fn _ -> "A" end == error "A"
  end
end
