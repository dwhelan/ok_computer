defmodule Lily.Operator do
  @moduledoc """
  Creates operators using anonymous functions.

  Lily operators extends Elixir operators with anonymous functions.

  Instead of defining an operator using `def` or `defmacro`,
  you provide an equivalent anonymous function to `operator/1` or `operator_macro/1`.

  Use a function of arity one for unary operators and a function of arity two for binary operators.

  The `Concat` module below creates concat operators
  with Elixir operators and Lily operators:

  ```
  #{File.read!("test/lily/support/concat.ex")}
  ```
  ```
        iex> import Concat
        iex> "a" >>> "b" # <- Elixir operator
        "ab"
        iex> "a" <<< "b" # <- Lily operator
        "ab"
  ```

  ## Supported Operators
  Lily supports all the Elixir operators except:
  `.`, `=>`, `^`, `not in`, `when` as these are used by the Elixir parser.

  | Operator    | Associativity        |
  |:-----------:|:---------------------|
  | `!`         | Unary                |
  | `@`         | Unary                |
  | `~~~`       | Unary                |
  | `&`         | Unary                |
  | `+`         | Unary, Left to Right |
  | `-`         | Unary, Left to Right |
  | `*`         | Left to Right        |
  | `/`         | Left to Right        |
  | `^^^`       | Left to Right        |
  | `&&`        | Left to Right        |
  | `&&&`       | Left to Right        |
  | `<-`        | Left to Right        |
  | `\\\\`      | Left to Right        |
  | `\\|\\|`    | Left to Right        |
  | `\\|\\|\\|` | Left to Right        |
  | `=~`        | Left to Right        |
  | `==`        | Left to Right        |
  | `===`       | Left to Right        |
  | `!=`        | Left to Right        |
  | `!==`       | Left to Right        |
  | `<`         | Left to Right        |
  | `>`         | Left to Right        |
  | `<=`        | Left to Right        |
  | `\\|>`      | Left to Right        |
  | `>=`        | Left to Right        |
  | `<\\|>`     | Left to Right        |
  | `<~>`       | Left to Right        |
  | `~>`        | Left to Right        |
  | `~>>`       | Left to Right        |
  | `>>>`       | Left to Right        |
  | `<~`        | Left to Right        |
  | `<<~`       | Left to Right        |
  | `<<<`       | Left to Right        |
  | `in`        | Left to Right        |
  | `and`       | Left to Right        |
  | `or`        | Left to Right        |
  | `not`       | Left to Right        |
  | `..`        | Right to Left        |
  | `=`         | Right to Left        |
  | `++`        | Right to Left        |
  | `--`        | Right to Left        |
  | `\\|`       | Right to Left        |
  | `<>`        | Right to Left        |
  """

  alias Lily.Error

  import Lily.Function

  @doc """
  Creates operators.

  Inserts operator functions for each operator in `operators`.
  The key is the operator name and the value is the function that the operator should call.
  The function should return an expression which results from the operator inputs.

  ## Examples
  Math operators that work with numbers or complex numbers expressed as `{real, imaginary}`:

  ```
  #{File.read!("test/lily/support/math.ex")}
  ```

  Regular math:

        iex> use Math
        iex> +1
        1
        iex> 1 + 2
        3

  Complex math:

        iex> use Math
        iex> +{1, 2}
        {1, 2}
        iex> {1, 2} + {3, 4}
        {4, 6}
  """
  @spec operator(keyword(f :: Macro.t())) :: Macro.t()
  defmacro operator(operators) do
    operator(operators, __CALLER__)
  end

  @doc """
  Creates operator macros.

  Insert operator macros for each operator in the `operators` keyword list.
  The key is the operator name and the value is the function that the operator should call.
  The function should return a quoted expression.

  ## Examples
  A tee `a ~> function_call` operator that calls `IO.inspect(a)` and then ``.
  This could be useful for inspecting intermediate values in a pipeline.

  ```
  #{File.read!("test/lily/support/io_inspect.ex")}
  ```
        iex> import IO.Inspect
        iex> :a ~> to_string() # => :a
        "a"
  """
  @spec operator_macro(keyword(f :: Macro.t())) :: Macro.t()
  defmacro operator_macro(operators) do
    operator_macro(operators, __CALLER__)
  end

  @doc """
  Returns the AST to create an operator.

  This is useful for programmatically creating operators.
  """
  @spec operator(keyword(f :: Macro.t()), Macro.Env.t()) :: Macro.t()
  def operator(operators, env) do
    create(:def, operators, env)
  end

  @doc """
  Returns the AST to create an operator macro.

  This is useful for programmatically creating operator macros.
  """
  @spec operator_macro(keyword(f :: Macro.t()), Macro.Env.t()) :: Macro.t()
  def operator_macro(operators, env) do
    create(:defmacro, operators, env)
  end

  defp create(type, operators, env) do
    [
      Enum.map(
        operators,
        fn {operator, f} -> create(type, operator, f, env) end
      )
    ]
  end

  defp create(_, operator, _, _) when operator in [:., :"=>", :^, :"not in", :when] do
    raise Error, "can't use #{operator}, because it is used by the Elixir parser."
  end

  defp create(type, operator, f, env) do
    arity = arity(f, env)
    operator_arities = arities(operator)

    cond do
      operator_arities == [] ->
        raise Error,
              "expected an operator but got #{operator}."

      arity not in operator_arities ->
        raise Error,
              "expected an operator function for #{operator} with arity in #{
                inspect(operator_arities)
              }, but got an operator function with arity #{arity}."

      true ->
        operator(type, operator, f, arity)
    end
  end

  defp operator(:def, operator, f, 1) do
    quote do
      import Kernel, except: [{unquote(operator), 1}]

      def unquote(operator)(a) do
        unquote(f).(a)
      end
    end
  end

  defp operator(:def, operator, f, 2) do
    quote do
      import Kernel, except: [{unquote(operator), 2}]

      def unquote(operator)(a, b) do
        unquote(f).(a, b)
      end
    end
  end

  defp operator(:defmacro, operator, f, 1) do
    quote do
      import Kernel, except: [{unquote(operator), 1}]

      defmacro unquote(operator)(a) do
        unquote(f).(a)
      end
    end
  end

  defp operator(:defmacro, operator, f, 2) do
    quote do
      import Kernel, except: [{unquote(operator), 2}]
      import Lily.Operator

      defmacro unquote(operator)(a, b) do
        unquote(f).(a, b)
      end
    end
  end

  @doc """
  Returns an operator macro function that calls a tap function before piping.

  You provide a function of arity 1 that will be called with the input.

  The operator macro function will call your function and
  then pipe the left input to the function call on the right.

  This can be useful for inserting effects.

  ## Examples
  A tap operator that calls `IO.inspect/1`.
  ```
  #{File.read!("test/lily/support/io_inspect.ex")}
  ```
        iex> import IO.Inspect
        iex> :a ~> to_string() # IO.inspect(:a) is called, :a is piped through
        "a"

  This could be useful for inspecting intermediate values in a pipeline.

        iex> import IO.Inspect
        iex> "a b"
        ...>   ~> String.upcase() # > "a b"
        ...>   ~> String.split()  # > "A B"
        ["A", "B"]

  Using `~>` results in the `IO.inspect/1` being called but is otherwise identical to `|>`.
  """
  @spec tap((any -> any)) :: (any, function -> Macro.t())
  def tap(tap) when is_function(tap, 1) do
    fn a, f ->
      quote do
        a = unquote(a)
        unquote(tap).(a)
        a |> unquote(f)
      end
    end
  end

  defp arities(operator) do
    Enum.filter([1, 2], fn arity -> Macro.operator?(operator, arity) end)
  end
end
