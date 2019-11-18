defmodule Operator.PipeTest do
  use ExUnit.Case
  alias Lily.Error
  alias OkComputer.Pipe
  import Pipe

  test "operator arity should be two" do
    assert_raise(
      Error,
      ~r/operator with arity 2/,
      fn -> create([!: quote(do: fn a -> nil end)], __ENV__) end
    )
  end
end
