defmodule OkComputer.OperatorTest do
  use ExUnit.Case
  import OkComputer.Test
  import OkComputer.Operator

  test "arity of anonymous function" do
    f1 = quote(do: fn a -> nil end)
    f2 = quote(do: fn a, b -> nil end)

    assert arity(f1) == 1
    assert arity(f2) == 2
  end

  test "arity of anonymous function using &" do
    c1 = quote(do: & &1)
    c2 = quote(do: & &1 + &2)

    assert arity(c1) == 1
    assert arity(c2) == 2
  end

  test "arity of remote capture" do
    c1 = quote(do: &Kernel.to_string/1)
    c2 = quote(do: &Kernel.apply/2)

    assert arity(c1) == 1
    assert arity(c2) == 2
  end

  test "arity of local capture" do
    c1 = quote(do: &to_string/1)
    c2 = quote(do: &apply/2)

    assert arity(c1) == 1
    assert arity(c2) == 2
  end

  @g quote(do: &Kernel.to_string/1)

  test "var function" do
    assert arity2(@g) == 1
  end
end
