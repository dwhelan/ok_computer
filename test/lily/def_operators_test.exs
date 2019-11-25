defmodule Lily.DefOperatorsTest do
  use ExUnit.Case

  import Lily.Operator
  import Lily.Test

  operator(
    # unary
    @: &to_string/1,
    +: &to_string/1,
    -: &to_string/1,
    !: &to_string/1,
    not: &to_string/1,
    ~~~: &to_string/1,

    # binary
    *: &to_string/2,
    /: &to_string/2,
    +: &to_string/2,
    -: &to_string/2,
    ++: &to_string/2,
    --: &to_string/2,
    ..: &to_string/2,
    <>: &to_string/2,
    ^^^: &to_string/2,
    in: &to_string/2,
    |>: &to_string/2,
    <<<: &to_string/2,
    >>>: &to_string/2,
    <<~: &to_string/2,
    ~>>: &to_string/2,
    <~: &to_string/2,
    ~>: &to_string/2,
    <~>: &to_string/2,
    <|>: &to_string/2,
    <: &to_string/2,
    >: &to_string/2,
    <=: &to_string/2,
    >=: &to_string/2,
    !=: &to_string/2,
    =~: &to_string/2,
    ===: &to_string/2,
    !==: &to_string/2,
    &&: &to_string/2,
    &&&: &to_string/2,
    and: &to_string/2,
    ||: &to_string/2,
    |||: &to_string/2,
    or: &to_string/2,
    =: &to_string/2,
    |: &to_string/2,
    "::": &to_string/2,
    <-: &to_string/2,
    \\: &to_string/2
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
