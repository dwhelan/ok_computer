defmodule Lily.DefOperatorsTest do
  use ExUnit.Case

  import Lily.Operator

  defoperators(
    # unary
    @: fn a -> "#{a}" end,
    +: fn a -> "#{a}" end,
    -: fn a -> "#{a}" end,
    !: fn a -> "#{a}" end,
    not: fn a -> "#{a}" end,
    ~~~: fn a -> "#{a}" end,

    # binary
    *: fn a, b -> "#{a}#{b}" end,
    /: fn a, b -> "#{a}#{b}" end,
    +: fn a, b -> "#{a}#{b}" end,
    -: fn a, b -> "#{a}#{b}" end,
    ++: fn a, b -> "#{a}#{b}" end,
    --: fn a, b -> "#{a}#{b}" end,
    ..: fn a, b -> "#{a}#{b}" end,
    <>: fn a, b -> "#{a}#{b}" end,
    ^^^: fn a, b -> "#{a}#{b}" end,
    in: fn a, b -> "#{a}#{b}" end,
    |>: fn a, b -> "#{a}#{b}" end,
    <<<: fn a, b -> "#{a}#{b}" end,
    >>>: fn a, b -> "#{a}#{b}" end,
    <<~: fn a, b -> "#{a}#{b}" end,
    ~>>: fn a, b -> "#{a}#{b}" end,
    <~: fn a, b -> "#{a}#{b}" end,
    ~>: fn a, b -> "#{a}#{b}" end,
    <~>: fn a, b -> "#{a}#{b}" end,
    <|>: fn a, b -> "#{a}#{b}" end,
    <: fn a, b -> "#{a}#{b}" end,
    >: fn a, b -> "#{a}#{b}" end,
    <=: fn a, b -> "#{a}#{b}" end,
    >=: fn a, b -> "#{a}#{b}" end,
    !=: fn a, b -> "#{a}#{b}" end,
    =~: fn a, b -> "#{a}#{b}" end,
    ===: fn a, b -> "#{a}#{b}" end,
    !==: fn a, b -> "#{a}#{b}" end,
    &&: fn a, b -> "#{a}#{b}" end,
    &&&: fn a, b -> "#{a}#{b}" end,
    and: fn a, b -> "#{a}#{b}" end,
    ||: fn a, b -> "#{a}#{b}" end,
    |||: fn a, b -> "#{a}#{b}" end,
    or: fn a, b -> "#{a}#{b}" end,
    =: fn a, b -> "#{a}#{b}" end,
    |: fn a, b -> "#{a}#{b}" end,
    "::": fn a, b -> "#{a}#{b}" end,
    <-: fn a, b -> "#{a}#{b}" end,
    \\: fn a, b -> "#{a}#{b}" end
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
