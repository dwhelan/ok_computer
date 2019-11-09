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
  operator :<>, fn left, right -> "#{left}#{right}"  end
  operator :^^^, fn left, right -> "#{left}#{right}"  end
  operator :in, fn left, right -> "#{left}#{right}"  end
  operator :|>, fn left, right -> "#{left}#{right}"  end
  operator :<<<, fn left, right -> "#{left}#{right}"  end
  operator :>>>, fn left, right -> "#{left}#{right}"  end
  operator :<<~, fn left, right -> "#{left}#{right}"  end
  operator :~>>, fn left, right -> "#{left}#{right}"  end
  operator :<~, fn left, right -> "#{left}#{right}"  end
  operator :~>, fn left, right -> "#{left}#{right}"  end
  operator :<~>, fn left, right -> "#{left}#{right}"  end
  operator :<|>, fn left, right -> "#{left}#{right}"  end

  test "*", do: assert(:a * :b == "ab")
  test "/", do: assert(:a / :b == "ab")
  test "+/2", do: assert(:a + :b == "ab")
  test "-/2", do: assert(:a - :b == "ab")
  test "++", do: assert(:a ++ :b == "ab")
  test "--", do: assert(:a -- :b == "ab")
  test "..", do: assert(:a .. :b == "ab")
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

  test "./2" do
    assert_raise SyntaxError, ~r"syntax error before: b", fn ->
      Code.eval_string(":a . :b")
    end
  end

  # Should raise error
  operator :., fn left, right -> "#{left}#{right}" end
  operator :"not in", fn left, right -> "#{left}#{right}"  end
  #  test "./2", do: assert(.(:a, :b) == "ab")
  #  test "not in", do: assert(:a not in :b == "ab")
end
