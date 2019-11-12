defmodule Lily.OperatorMacroTest do
  use ExUnit.Case
  import Lily.Operator

  describe "unary operator macro" do
    operator_macro :@, fn input -> quote(do: "#{unquote(input)}") end
    operator_macro :+, fn input -> quote(do: "#{unquote(input)}") end
    operator_macro :-, fn input -> quote(do: "#{unquote(input)}") end
    operator_macro :!, fn input -> quote(do: "#{unquote(input)}") end
    operator_macro :not, fn input -> quote(do: "#{unquote(input)}") end
    operator_macro :~~~, fn input -> quote(do: "#{unquote(input)}") end

    test "@", do: assert(@:a == "a")
    test "+/1", do: assert(+:a == "a")
    test "-/1", do: assert(-:a == "a")
    test "!", do: assert(!:a == "a")
    test "not", do: assert(not :a == "a")
    test "~~~", do: assert(~~~:a == "a")
  end

  describe "binary operator macro" do
    operator_macro :*, fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end
    operator_macro :/, fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end
    operator_macro :+, fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end
    operator_macro :-, fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end
    operator_macro :++, fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end
    operator_macro :--, fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end
    operator_macro :.., fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end
    operator_macro :<>, fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end
    operator_macro :^^^, fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end
    operator_macro :in, fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end
    operator_macro :|>, fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end
    operator_macro :<<<, fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end
    operator_macro :>>>, fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end
    operator_macro :<<~, fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end
    operator_macro :~>>, fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end
    operator_macro :<~, fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end
    operator_macro :~>, fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end
    operator_macro :<~>, fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end
    operator_macro :<|>, fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end
    operator_macro :<, fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end
    operator_macro :>, fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end
    operator_macro :<=, fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end
    operator_macro :>=, fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end
    operator_macro :!=, fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end
    operator_macro :=~, fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end
    operator_macro :===, fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end
    operator_macro :!==, fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end
    operator_macro :&&, fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end
    operator_macro :&&&, fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end
    operator_macro :and, fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end
    operator_macro :||, fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end
    operator_macro :|||, fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end
    operator_macro :or, fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end
    operator_macro :=, fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end
    operator_macro :|, fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end
    operator_macro :"::", fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end
    operator_macro :<-, fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end
    operator_macro :\\, fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end

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
