defmodule OkComputer.Operator.BinaryMacroTest do
  use ExUnit.Case
  import OkComputer.Test
  import OkComputer.Operator

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
end
