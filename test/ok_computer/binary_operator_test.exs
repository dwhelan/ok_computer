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
    assert_eval_raise(
      OkComputer.OperatorError,
      ~r/cannot create an operator for \".\", because it is used by the Elixir parser./,
      ~S"""
      defmodule OkComputer.BadOperator do
        import OkComputer.Operator
        operator :".", fn left, right -> "#{left}#{right}" end
      end
      """
    )
  end

  test "can't use 'not in'" do
    assert_eval_raise(
      OkComputer.OperatorError,
      ~r/cannot create an operator for \"not in\", because it is used by the Elixir parser./,
      ~S"""
      defmodule OkComputer.BadOperator do
        import OkComputer.Operator
        operator :"not in", fn left, right -> "#{left}#{right}"  end
      end
      """
    )
  end

  test "can't use '=>'" do
    assert_eval_raise(
      OkComputer.OperatorError,
      ~r/cannot create an operator for \"=>\", because it is used by the Elixir parser./,
      ~S"""
      defmodule OkComputer.BadOperator do
        import OkComputer.Operator
        operator :"=>", fn left, right -> "#{left}#{right}"  end
      end
      """
    )
  end

  test "can't use 'when'" do
    assert_eval_raise(
      OkComputer.OperatorError,
      ~r/cannot create an operator for \"when\", because it is used by the Elixir parser./,
      ~S"""
      defmodule OkComputer.BadOperator do
        import OkComputer.Operator
        operator :when, fn left, right -> "#{left}#{right}"  end
      end
      """
    )
  end

  defp assert_eval_raise(given_exception, given_message, string) do
    assert_raise given_exception, given_message, fn -> Code.eval_string(string) end
  end
end
