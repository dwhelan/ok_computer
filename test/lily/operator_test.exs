defmodule Lily.OperatorTest do
  use ExUnit.Case
  alias Lily.{Operator, Error}
  import Operator

  operator(
    -: fn a -> "#{a}" end,
    +: &"#{&1}",
    @: &to_string/1,
    !: &Kernel.to_string/1,
    ~>: fn a, b -> "#{a}#{b}" end,
    ~>>: &"#{&1}#{&2}",
    <~: &__MODULE__.to_string/2
  )

  def to_string(a, b) do
    "#{a}#{b}"
  end

  describe "operator: unary operator with" do
    test "anonymous function", do: assert(-:a == "a")
    test "capture operator", do: assert(+:a == "a")
    test "local capture", do: assert(@:a == "a")
    test "remote capture", do: assert(!:a == "a")
  end

  describe "operator binary operator with" do
    test "anonymous function", do: assert(:a ~> :b == "ab")
    test "capture operator", do: assert(:a ~>> :b == "ab")
    test "remote capture", do: assert(:a <~ :b == "ab")
  end

  describe "operator/2" do
    test ~S/raise if operator in [:., :"=>", :^, :"not in", :when]/ do
      Enum.each([:., :"=>", :^, :"not in", :when], fn operator ->
        assert_raise(
          Error,
          ~r/used by the Elixir parser/,
          fn -> operator([{operator, quote(do: &to_string/1)}], __ENV__) end
        )
      end)
    end

    test "raise if operator is not an Elixir operator" do
      assert_raise(
        Error,
        ~r/expected an operator/,
        fn -> operator([{:foo, quote(do: &to_string/1)}], __ENV__) end
      )
    end
  end

  describe "operator_macro/2" do
    test ~S/raise if operator in [:., :"=>", :^, :"not in", :when]/ do
      Enum.each([:., :"=>", :^, :"not in", :when], fn operator ->
        assert_raise(
          Error,
          ~r/used by the Elixir parser/,
          fn -> operator_macro([{operator, quote(do: &to_string/1)}], __ENV__) end
        )
      end)
    end

    test "raise if operator is not an Elixir operator" do
      assert_raise(
        Error,
        ~r/expected an operator/,
        fn -> operator_macro([{:foo, quote(do: &to_string/1)}], __ENV__) end
      )
    end
  end
end
