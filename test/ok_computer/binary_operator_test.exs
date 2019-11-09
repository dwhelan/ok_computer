defmodule OkComputer.BinaryOperatorTest do
  use ExUnit.Case
  import OkComputer.Operator

  operator :*, fn left, right -> "#{left}#{right}" end
  operator :/, fn left, right -> "#{left}#{right}" end
  operator :+, fn left, right -> "#{left}#{right}" end
  operator :-, fn left, right -> "#{left}#{right}" end
  operator :++, fn left, right -> "#{left}#{right}" end
  operator :--, fn left, right -> "#{left}#{right}" end
  operator :.., fn left, right -> "#{left}#{right}" end
  operator :<>, fn left, right -> "#{left}#{right}" end
  operator :^^^, fn left, right -> "#{left}#{right}" end
  operator :in, fn left, right -> "#{left}#{right}" end
  operator :|>, fn left, right -> "#{left}#{right}" end
  operator :<<<, fn left, right -> "#{left}#{right}" end
  operator :>>>, fn left, right -> "#{left}#{right}" end
  operator :<<~, fn left, right -> "#{left}#{right}" end
  operator :~>>, fn left, right -> "#{left}#{right}" end
  operator :<~, fn left, right -> "#{left}#{right}" end
  operator :~>, fn left, right -> "#{left}#{right}" end
  operator :<~>, fn left, right -> "#{left}#{right}" end
  operator :<|>, fn left, right -> "#{left}#{right}" end
  operator :<, fn left, right -> "#{left}#{right}" end
  operator :>, fn left, right -> "#{left}#{right}" end
  operator :<=, fn left, right -> "#{left}#{right}" end
  operator :>=, fn left, right -> "#{left}#{right}" end
  operator :!=, fn left, right -> "#{left}#{right}" end
  operator :=~, fn left, right -> "#{left}#{right}" end
  operator :===, fn left, right -> "#{left}#{right}" end
  operator :!==, fn left, right -> "#{left}#{right}" end
  operator :&&, fn left, right -> "#{left}#{right}" end
  operator :&&&, fn left, right -> "#{left}#{right}" end
  operator :and, fn left, right -> "#{left}#{right}" end
  operator :||, fn left, right -> "#{left}#{right}" end
  operator :|||, fn left, right -> "#{left}#{right}" end
  operator :or, fn left, right -> "#{left}#{right}" end
  operator :=, fn left, right -> "#{left}#{right}" end
  operator :|, fn left, right -> "#{left}#{right}" end
  operator :"::", fn left, right -> "#{left}#{right}" end
  operator :<-, fn left, right -> "#{left}#{right}" end
  operator :\\, fn left, right -> "#{left}#{right}" end

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

  operator :., fn left, right -> "#{left}#{right}" end

  test "./2" do
    assert_raise SyntaxError, ~r"syntax error before: b", fn ->
      Code.eval_string(":a . :b")
    end
  end

  # Should raise error
  operator :., fn left, right -> "#{left}#{right}" end
  #  test "./2", do: assert(.(:a, :b) == "ab")

  operator :"not in", fn left, right -> "#{left}#{right}" end
  #  test "not in", do: assert(:a not in :b == "ab")

  #  operator :==, fn left, right -> "#{left}#{right}"  end
  #  test "==", do: assert(:a == :b == "ab")

  #  operator :=, fn left, right -> "#{left}#{right}"  end
  #  test "=", do: assert((:a = :b) == "ab")

  #  operator :=>, fn left, right -> "#{left}#{right}" end
  #  test "=>", do: assert(:a => :b == "ab")

  #  operator :when, fn left, right -> "#{left}#{right}" end
  #  test "when", do: assert(:a when :b == "ab")
end
