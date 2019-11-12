defmodule Lily.OperatorTest do
  use ExUnit.Case
  import Lily.Operator
  alias Lily.OperatorError

  describe "type" do
    test "raise if type is not :def or :defmacro" do
      assert_raise(OperatorError, fn ->
        create(:foo, :+, quote(do: &to_string/1))
      end)
    end
  end

  describe "atom" do
    test ~S/raise if in [:., :"=>", :^, :"not in", :when]/ do
      Enum.each([:., :"=>", :^, :"not in", :when], fn atom ->
        assert_raise(OperatorError, ~r/parser/, fn ->
          create(:def, atom, quote(do: &to_string/1))
        end)
      end)
    end

    test "raise if atom is not an operator" do
      assert_raise(OperatorError, fn ->
        create(:def, :foo, quote(do: &to_string/1))
      end)
    end
  end

  describe "unary operator" do
    operator :@, fn a -> "#{a}" end
    operator :+, fn a -> "#{a}" end
    operator :-, fn a -> "#{a}" end
    operator :!, fn a -> "#{a}" end
    operator :not, fn a -> "#{a}" end
    operator :~~~, fn a -> "#{a}" end

    test "@", do: assert(@:a == "a")
    test "+/1", do: assert(+:a == "a")
    test "-/1", do: assert(-:a == "a")
    test "!", do: assert(!:a == "a")
    test "not", do: assert(not :a == "a")
    test "~~~", do: assert(~~~:a == "a")
  end

  describe "binary operator" do
    operator :*, fn a, b -> "#{a}#{b}" end
    operator :/, fn a, b -> "#{a}#{b}" end
    operator :+, fn a, b -> "#{a}#{b}" end
    operator :-, fn a, b -> "#{a}#{b}" end
    operator :++, fn a, b -> "#{a}#{b}" end
    operator :--, fn a, b -> "#{a}#{b}" end
    operator :.., fn a, b -> "#{a}#{b}" end
    operator :<>, fn a, b -> "#{a}#{b}" end
    operator :^^^, fn a, b -> "#{a}#{b}" end
    operator :in, fn a, b -> "#{a}#{b}" end
    operator :|>, fn a, b -> "#{a}#{b}" end
    operator :<<<, fn a, b -> "#{a}#{b}" end
    operator :>>>, fn a, b -> "#{a}#{b}" end
    operator :<<~, fn a, b -> "#{a}#{b}" end
    operator :~>>, fn a, b -> "#{a}#{b}" end
    operator :<~, fn a, b -> "#{a}#{b}" end
    operator :~>, fn a, b -> "#{a}#{b}" end
    operator :<~>, fn a, b -> "#{a}#{b}" end
    operator :<|>, fn a, b -> "#{a}#{b}" end
    operator :<, fn a, b -> "#{a}#{b}" end
    operator :>, fn a, b -> "#{a}#{b}" end
    operator :<=, fn a, b -> "#{a}#{b}" end
    operator :>=, fn a, b -> "#{a}#{b}" end
    operator :!=, fn a, b -> "#{a}#{b}" end
    operator :=~, fn a, b -> "#{a}#{b}" end
    operator :===, fn a, b -> "#{a}#{b}" end
    operator :!==, fn a, b -> "#{a}#{b}" end
    operator :&&, fn a, b -> "#{a}#{b}" end
    operator :&&&, fn a, b -> "#{a}#{b}" end
    operator :and, fn a, b -> "#{a}#{b}" end
    operator :||, fn a, b -> "#{a}#{b}" end
    operator :|||, fn a, b -> "#{a}#{b}" end
    operator :or, fn a, b -> "#{a}#{b}" end
    operator :=, fn a, b -> "#{a}#{b}" end
    operator :|, fn a, b -> "#{a}#{b}" end
    operator :"::", fn a, b -> "#{a}#{b}" end
    operator :<-, fn a, b -> "#{a}#{b}" end
    operator :\\, fn a, b -> "#{a}#{b}" end

    test "*", do: assert(:a * :b == "ab")
    test "/", do: assert(:a / :b == "ab")
    test "+/2", do: assert(:a + :b == "ab")
    test "-/2", do: assert(:a - :b == "ab")
    test "++", do: assert(:a ++ :b == "ab")
    test "--", do: assert(:a -- :b == "ab")
    test "..", do: assert(:a..:b == "ab")
    test "<>", do: assert(:a <> :b == "ab")
    test "^^^", do: assert(:a ^^^ :b == "ab")
    test "in", do: assert(:a in :b == "ab")
    test "|>", do: assert(:a |> :b == "ab")
    test "<<<", do: assert(:a <<< :b == "ab")
    test ">>>", do: assert(:a >>> :b == "ab")
    test "<<~", do: assert(:a <<~ :b == "ab")
    test "~>>", do: assert(:a ~>> :b == "ab")
    test "<~", do: assert(:a <~ :b == "ab")
    test "~>", do: assert(:a ~> :b == "ab")
    test "<~>", do: assert(:a <~> :b == "ab")
    test "<|>", do: assert(:a <|> :b == "ab")
    test "<", do: assert(:a < :b == "ab")
    test ">", do: assert(:a > :b == "ab")
    test "<=", do: assert(:a <= :b == "ab")
    test ">=", do: assert(:a >= :b == "ab")
    test "!=", do: assert(:a != :b == "ab")
    test "=~", do: assert(:a =~ :b == "ab")
    test "===", do: assert(:a === :b == "ab")
    test "!==", do: assert(:a !== :b == "ab")
    test "&&", do: assert((:a && :b) == "ab")
    test "&&&", do: assert((:a &&& :b) == "ab")
    test "and", do: assert((:a and :b) == "ab")
    test "||", do: assert((:a || :b) == "ab")
    test "|||", do: assert((:a ||| :b) == "ab")
    test "or", do: assert((:a or :b) == "ab")
    test "|", do: assert((:a | :b) == "ab")
    test "::", do: assert((:a :: :b) == "ab")
    test ":<-", do: assert((:a <- :b) == "ab")
    test ":\\", do: assert((:a \\ :b) == "ab")
  end
end
