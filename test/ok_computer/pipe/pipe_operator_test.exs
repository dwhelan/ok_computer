defmodule OkComputer.Pipe.Ok do
  def pipe_operator do
    fn left, right ->
      quote do
        left = unquote(left)

        case left do
          {:ok, value} -> {:ok, value |> unquote(right)}
          _ -> left
        end
      end
    end
  end
end

defmodule OkComputer.Pipe.OkTest do
  use ExUnit.Case
  import OkComputer.Operator

  operator_macro :~>, OkComputer.Pipe.Ok.pipe_operator()

  test "~>/2" do
    assert {:ok, :a} ~> to_string() == {:ok, "a"}
    assert :a ~> to_string() == :a
  end
end
