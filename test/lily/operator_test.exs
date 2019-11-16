defmodule Lily.OperatorTest do
  use ExUnit.Case
  alias Lily.{Operator, Error}
  import Operator

  describe "type" do
    #    test "raise if type is not :def or :defmacro" do
    #      assert_raise(
    #        Error,
    #        ~r/expected type to be :def or :defmacro/,
    #        fn -> create(:foo, +: quote(do: &to_string/1)) end
    #      )
    #    end
  end

  describe "operator" do
    test ~S/raise if in [:., :"=>", :^, :"not in", :when]/ do
      Enum.each([:., :"=>", :^, :"not in", :when], fn operator ->
        assert_raise(
          Error,
          ~r/used by the Elixir parser/,
          fn -> create(:def, [{operator, quote(do: &to_string/1)}]) end
        )
      end)
    end

    test "raise if atom is not an operator" do
      assert_raise(
        Error,
        ~r/expected an operator/,
        fn -> create(:def, [{:foo, quote(do: &to_string/1)}]) end
      )
    end
  end

  def to_string(a, b) do
    "#{a}#{b}"
  end

  defoperators(
    -: fn a -> "#{a}" end,
    +: &"#{&1}",
    @: &to_string/1,
    !: &Kernel.to_string/1,
    ~>: fn a, b -> "#{a}#{b}" end,
    ~>>: &"#{&1}#{&2}",
    <~: &__MODULE__.to_string/2
  )

  describe "operator function/1: " do
    test "anonymous", do: assert(-:a == "a")
    test "capture operator", do: assert(+:a == "a")
    test "local capture", do: assert(@:a == "a")
    test "remote capture", do: assert(!:a == "a")
  end

  describe "operator function/2: " do
    test "anonymous", do: assert(:a ~> :b == "ab")
    test "capture operator", do: assert(:a ~>> :b == "ab")
    test "remote capture", do: assert(:a <~ :b == "ab")
  end

  defoperator_macros(
    >>>: Lily.Operator.tee(&IO.inspect/1)
  )

  test "tee" do
    assert :a >>> to_string() == "a"
  end
end
