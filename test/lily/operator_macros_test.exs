defmodule Lily.OperatorMacrosTest do
  use ExUnit.Case
  import Lily.Operator

  operator_macros(
    # unary
    @: fn input -> quote(do: "#{unquote(input)}") end,
    +: fn input -> quote(do: "#{unquote(input)}") end,
    -: fn input -> quote(do: "#{unquote(input)}") end,
    !: fn input -> quote(do: "#{unquote(input)}") end,
    not: fn input -> quote(do: "#{unquote(input)}") end,
    ~~~: fn input -> quote(do: "#{unquote(input)}") end,

    # binary
    *: fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end,
    /: fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end,
    +: fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end,
    -: fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end,
    ++: fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end,
    --: fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end,
    ..: fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end,
    <>: fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end,
    ^^^: fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end,
    in: fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end,
    |>: fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end,
    <<<: fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end,
    >>>: fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end,
    <<~: fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end,
    ~>>: fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end,
    <~: fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end,
    ~>: fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end,
    <~>: fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end,
    <|>: fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end,
    <: fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end,
    >: fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end,
    <=: fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end,
    >=: fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end,
    !=: fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end,
    =~: fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end,
    ===: fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end,
    !==: fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end,
    &&: fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end,
    &&&: fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end,
    and: fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end,
    ||: fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end,
    |||: fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end,
    or: fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end,
    =: fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end,
    |: fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end,
    "::": fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end,
    <-: fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end,
    \\: fn left, right -> quote(do: "#{unquote(left)}#{unquote(right)}") end
  )

  describe "unary" do
    test "@", do: assert(@:a == "a")
    test "+/1", do: assert(+:a == "a")
    test "-/1", do: assert(-:a == "a")
    test "!", do: assert(!:a == "a")
    test "not", do: assert(not :a == "a")
    test "~~~", do: assert(~~~:a == "a")
  end

  describe "binary" do
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
