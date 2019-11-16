defmodule Lily.DefMacroOperatorsTest do
  use ExUnit.Case
  import Lily.Test
  import Lily.Operator

  defoperator_macros(
    # unary
    @: &quoted_to_string/1,
    +: &quoted_to_string/1,
    -: &quoted_to_string/1,
    !: &quoted_to_string/1,
    not: &quoted_to_string/1,
    ~~~: &quoted_to_string/1,

    # binary
    *: &quoted_to_string/2,
    /: &quoted_to_string/2,
    +: &quoted_to_string/2,
    -: &quoted_to_string/2,
    ++: &quoted_to_string/2,
    --: &quoted_to_string/2,
    ..: &quoted_to_string/2,
    <>: &quoted_to_string/2,
    ^^^: &quoted_to_string/2,
    in: &quoted_to_string/2,
    |>: &quoted_to_string/2,
    <<<: &quoted_to_string/2,
    >>>: &quoted_to_string/2,
    <<~: &quoted_to_string/2,
    ~>>: &quoted_to_string/2,
    <~: &quoted_to_string/2,
    ~>: &quoted_to_string/2,
    <~>: &quoted_to_string/2,
    <|>: &quoted_to_string/2,
    <: &quoted_to_string/2,
    >: &quoted_to_string/2,
    <=: &quoted_to_string/2,
    >=: &quoted_to_string/2,
    !=: &quoted_to_string/2,
    =~: &quoted_to_string/2,
    ===: &quoted_to_string/2,
    !==: &quoted_to_string/2,
    &&: &quoted_to_string/2,
    &&&: &quoted_to_string/2,
    and: &quoted_to_string/2,
    ||: &quoted_to_string/2,
    |||: &quoted_to_string/2,
    or: &quoted_to_string/2,
    =: &quoted_to_string/2,
    |: &quoted_to_string/2,
    "::": &quoted_to_string/2,
    <-: &quoted_to_string/2,
    \\: &quoted_to_string/2
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
