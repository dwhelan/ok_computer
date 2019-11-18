defmodule Lily.Operator do
  @moduledoc """
  Creates operators using anonymous functions.

  Lily operators are more flexible than standard Elixir operators because you build them with anonymous functions.

  The `Concat` module below shows how you could create concat operators
  using standard operators and lily operators:

  ```
  #{File.read!("test/lily/support/concat.ex")}
  ```
        iex> use Concat
        iex> import Kernel, except: [+: 2, ++: 2]
        iex> "a" + "b" # <- standard operator
        "ab"
        iex> "a" ++ "b" # <- lily operator
        "ab"

  With lily operators, instead of declaring an operator using `def` or `defmacro`,
  you provide an equivalent anonymous function to `defoperators/1` or `defoperator_macros/1`.
  Use a function of arity one for unary operators and a function of arity two for binary operators.

  By default, a `__using__` macro will be inserted that imports `Kernel`,
  (except the operators you created) and then imports itself.
  This allows a module with operators to be easily used.
  If you don't want this behaviour, include `{:__using__, false}` in `operators`.

  ## Unsupported Operators
  Lily supports all the Elixir operators except:
  `.`, `=>`, `^`, `not in`, `when` as these are used by the Elixir parser.
  """

  alias Lily.Error

  #  Module.register_attribute(__MODULE__, :operators, accumulate: true)

  @doc """
  Creates operators.

  Insert operator functions for each operator in `operators`.
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
  @spec defoperators(keyword(f :: Macro.t())) :: Macro.t()
  defmacro defoperators(operators) do
    create(:def, operators, __CALLER__)
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
  #{File.read!("test/lily/support/inspect_tap.ex")}
  ```

        iex> use InspectTap
        iex> :a ~> to_string() # => :a
        "a"
  """
  @spec defoperator_macros(keyword(f :: Macro.t())) :: Macro.t()
  defmacro defoperator_macros(operators) do
    create(:defmacro, operators, __CALLER__)
  end

  @doc """
  Returns the AST to create an operator or an operator macro.

  This is useful for programmatically creating operators.

  If you want to create an operator function provide `:def` as the first argument.
  If you want to create an operator macro provide `:defmacro` instead.
  """
  @spec create(:def | :defmacro, keyword(f :: Macro.t()), Macro.Env.t()) :: Macro.t()
  def create(type, operators, env) do
    {using, operators} =
      Keyword.get_and_update(
        operators,
        :__using__,
        fn _ -> :pop end
      )

    [
      Enum.map(
        operators,
        fn {operator, f} -> create(type, operator, f, env) end
      ),
      if using != false do
        create__using__(operators, env)
      end
    ]
  end

  defp create(type, _, _, _) when type not in [:def, :defmacro] do
    raise Error, "expected type to be :def or :defmacro but got #{type}."
  end

  defp create(_, operator, _, _) when operator in [:., :"=>", :^, :"not in", :when] do
    raise Error, "can't use #{operator}, because it is used by the Elixir parser."
  end

  defp create(type, operator, f, env) do
    arity = arity(f, env)
    operator_arities = arities(operator)

    IO.inspect(operator: operator, arities: arities(operator))

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
        if env.module == Math do
          IO.inspect(putting_into: env.module, operator: {operator, arity})
          Module.put_attribute(env.module, :operators, {operator, arity})
          IO.inspect(operators: Module.get_attribute(env.module, :operators))
        else
          Module.put_attribute(env.module, :operators, {operator, arity})
        end

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

  defp create__using__(operators, env) do
    quote do
      defmacro __using__(_) do
        module = __MODULE__
        caller = __CALLER__

        kernel_excludes =
          unquote(Enum.map(operators, fn {operator, f} -> {operator, arity(f, env)} end))

        quote do
          import Kernel, except: unquote(kernel_excludes)
          import unquote(module)
        end
      end
    end
  end

  defmacro create__using__(operators) do
    quote do
      defmacro __using__(_) do
        module = __MODULE__
        caller = __CALLER__

        kernel_excludes = []

        quote do
          import Kernel, except: unquote(kernel_excludes)
          import unquote(module)
        end
      end
    end
  end

  @doc """
  Returns an operator macro function that calls a tap function before piping.

  ## Examples
  A tap operator that calls `IO.inspect/1`.

  ```
  #{File.read!("test/lily/support/inspect_tap.ex")}
  ```
        iex> use InspectTap
        iex> :a ~> to_string() # > :a
        "a"

  This could be useful for inspecting intermediate values in a pipeline.

        iex> "a b"
        ...>   |> String.upcase()
        ...>   |> String.split()
        ["A", "B"]

        iex> use InspectTap
        iex> "a b"
        ...>   ~> String.upcase() # > "a b"
        ...>   ~> String.split()  # > "A B"
        ["A", "B"]

  Using `~>` results in the input being inspected but is otherwise identical to `|>`.
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

  @spec arity(Macro.t(), Macro.Env.t()) :: integer
  def arity(f, env) do
    {f, _} = Code.eval_quoted(f, [], env)
    {:arity, arity} = Function.info(f, :arity)
    arity
  end

  defp arities(operator) do
    Enum.filter([1, 2], fn arity -> Macro.operator?(operator, arity) end)
  end

  defmacro __using__(_) do
    quote do
      alias Lily.Operator
      Module.register_attribute(__MODULE__, :operators, accumulate: true)
      IO.inspect(registering: __MODULE__)
      @before_compile Operator
      import Operator
    end
  end

  defmacro __before_compile__(env) do
    operators = Module.get_attribute(env.module, :operators)
    IO.inspect(module: env.module, operators: operators)
  end
end
