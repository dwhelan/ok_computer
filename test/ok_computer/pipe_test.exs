defmodule OkComputer.PipeTest do
  alias OkComputer.Monad.Value

  use ExUnit.Case
  import OkComputer.Pipe

  build :~>, Value, :bind

  test :~> do
    assert :a ~> to_string() == "a"
  end

  build :~>>, Value, :bind

  test :~>> do
    assert :a ~>> to_string() == "a"
  end
end
