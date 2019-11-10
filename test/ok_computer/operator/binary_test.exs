defmodule OkComputer.BinaryTest do
  use ExUnit.Case
  import OkComputer.Test
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
  test "+", do: assert(:a + :b == "ab")
  test "-", do: assert(:a - :b == "ab")
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

  # Operators that cannot be used

  test "can't use '.'" do
    assert_operator_error_raise(
      :.,
      ~S"""
      defmodule OkComputer.BadOperator do
        import OkComputer.Operator
        operator :".", fn left, right -> "#{left}#{right}" end
      end
      """
    )
  end

  test "can't use 'not in'" do
    assert_operator_error_raise(
      :"not in",
      ~S"""
      defmodule OkComputer.BadOperator do
        import OkComputer.Operator
        operator :"not in", fn left, right -> "#{left}#{right}"  end
      end
      """
    )
  end

  test "can't use '=>'" do
    assert_operator_error_raise(
      :"=>",
      ~S"""
      defmodule OkComputer.BadOperator do
        import OkComputer.Operator
        operator :"=>", fn left, right -> "#{left}#{right}"  end
      end
      """
    )
  end

  test "can't use 'when'" do
    assert_operator_error_raise(
      :when,
      ~S"""
      defmodule OkComputer.BadOperator do
        import OkComputer.Operator
        operator :when, fn left, right -> "#{left}#{right}"  end
      end
      """
    )
  end
end
