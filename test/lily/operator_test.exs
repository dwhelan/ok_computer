defmodule Lily.OperatorTest do
  use ExUnit.Case
  alias Lily.{Operator, Error}
  import Operator

  defoperators(
    -: fn a -> "#{a}" end,
    +: &"#{&1}",
    @: &to_string/1,
    !: &Kernel.to_string/1,
    ~>: fn a, b -> "#{a}#{b}" end,
    ~>>: &"#{&1}#{&2}",
    <~: &__MODULE__.to_string/2
  )

  describe "defoperators: unary operator with" do
    test "anonymous function", do: assert(-:a == "a")
    test "capture operator", do: assert(+:a == "a")
    test "local capture", do: assert(@:a == "a")
    test "remote capture", do: assert(!:a == "a")
  end

  describe "defoperators binary operator with" do
    test "anonymous function", do: assert(:a ~> :b == "ab")
    test "capture operator", do: assert(:a ~>> :b == "ab")
    test "remote capture", do: assert(:a <~ :b == "ab")
  end

  describe "create/3" do
    test "raise if type is not :def or :defmacro" do
      assert_raise(
        Error,
        ~r/expected type to be :def or :defmacro/,
        fn -> create(:foo, [+: quote(do: &to_string/1)], __ENV__) end
      )
    end

    test ~S/raise if operator in [:., :"=>", :^, :"not in", :when]/ do
      Enum.each([:., :"=>", :^, :"not in", :when], fn operator ->
        assert_raise(
          Error,
          ~r/used by the Elixir parser/,
          fn -> create(:def, [{operator, quote(do: &to_string/1)}], __ENV__) end
        )
      end)
    end

    test "raise if operator is not an Elixir operator" do
      assert_raise(
        Error,
        ~r/expected an operator/,
        fn -> create(:def, [{:foo, quote(do: &to_string/1)}], __ENV__) end
      )
    end
  end

  def to_string(a, b) do
    "#{a}#{b}"
  end
end
