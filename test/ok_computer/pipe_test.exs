defmodule OkComputer.PipeTest do
  alias OkComputer.Monad.Value

  use ExUnit.Case
  import OkComputer.Pipe

  pipe Value, bind: :~>

  test :~> do
    assert :a ~> to_string() == "a"
  end

  pipe Value, bind: :~>>

  test :~>> do
    assert :a ~>> to_string() == "a"
  end
end
