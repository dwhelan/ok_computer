defmodule Functions do
  def plus(a, b) do
    quote do
      unquote(a) + unquote(b)
    end
  end

  def pipe(left, right) do
    quote do
      unquote(left) |> unquote(right)
    end
  end

  def return(input) do
    quote do
      {:ok, unquote(input)}
    end
  end
end

defmodule OkComputer.NewOperatorTest do
  defmodule TildeRight do
    use ExUnit.Case
    import OkComputer.Operator

    operator(:~>, fn left, right ->
      quote do
        unquote(left) |> unquote(right)
      end
    end)

    test "~>" do
      assert :a ~> to_string() == "a"
    end
  end

  defmodule TildeRightRight do
    use ExUnit.Case
    import OkComputer.Operator

    operator(:~>>, fn left, right ->
      quote do
        unquote(left) |> unquote(right)
      end
    end)

    test "~>>" do
      assert :a ~>> to_string() == "a"
    end
  end
end

defmodule OkComputer.OperatorTest do
  use ExUnit.Case
  import OkComputer.Operator
  import Kernel, except: [+: 2]

  doctest OkComputer.Operator

  operators(Functions, +: [plus: 2], ~>: [pipe: 2])

  import OkComputer.OperatorTest.Operator.Functions

  test "math operator" do
    assert 1 + 2 == 3
  end

  test "pipe" do
    assert :a ~> to_string == "a"
  end

  test "return" do
    assert :a ~> to_string == "a"
  end
end
