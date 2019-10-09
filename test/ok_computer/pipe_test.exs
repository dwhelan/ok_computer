defmodule OkComputer.PipeTest do
  alias OkComputer.Monad.Value

  use ExUnit.Case
  import OkComputer.Pipe

  pipes(Value, bind: :~>)

  test :~> do
    assert :a ~> to_string() == "a"
  end

  pipes(Value, bind: :~>>)

  test :~>> do
    assert :a ~>> to_string() == "a"
  end
end
