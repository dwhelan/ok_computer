defmodule Lily.Operator do
  @moduledoc """
  Creates operators using anonymous functions.

  Operators can be more dynamic, by building them with anonymous functions.

  The `Concat` module below shows two ways you could create a concat operator:
  ```
  #{File.read!("test/support/concat.ex")}
  ```
        iex> use Concat
        iex> import Kernel, except: [+: 2, ++: 2]
        iex> :a + :b # <- standard operator
        "ab"
        iex> :a ++ :b # <- lily operator
        "ab"

  Instead of declaring an operator using `def`, you provide an equivalent anonymous function to `defoperators/1`.

  You can also create operator macros using `defoperator_macros/1`:
  ```
  #{File.read!("test/support/ok_pipe.ex")}
  ```

  By default, a `__using__` macro will be inserted that imports `Kernel`,
  (except the operators you created) and then imports itself.
  If you don't want this behaviour include `{:__using__, false}` in `operators`.
  """

  alias Lily.Error

  @doc """
  Creates operators.

  Insert operator functions for each operator in `operators`.
  The key is the operator name and the value is the function that the operator should call.
  The function should return an expression which results from the operator inputs.

  ## Examples
  Math operators that work with numbers or complex numbers expressed as `{real, imaginary}`:

  ```
  #{File.read!("test/support/complex.ex")}
  ```
        iex> use Complex
        iex> +1
        1
        iex> +{1, 2}
        {1, 2}
        iex> 1 + 2
        3
        iex> {1, 2} + {3, 4}
        {4, 6}
  """
  @spec defoperators(keyword(f :: Macro.t())) :: Macro.t()
  defmacro defoperators(operators) do
    create(:def, operators)
  end

  @doc """
  Creates operator macros.

  Insert operator macros for each operator in `operators`.
  The key is the operator name and the value is the function that the operator should call.
  The function should return a quoted expression.
  """
  @spec defoperator_macros(keyword(f :: Macro.t())) :: Macro.t()
  defmacro defoperator_macros(operators) do
    create(:defmacro, operators)
  end

  @doc """
  Returns the AST to create an operator or an operator macro.

  This is useful for programmatically creating operators.

  If you want to create an operator function provide `:def` as the first argument.
  If you want to create an operator macro provide `:defmacro` instead.
  """
  @spec create(:def | :defmacro, keyword(f :: Macro.t())) :: Macro.t()
  def create(type, operators) do
    {using, operators} = Keyword.get_and_update(operators, :__using__, fn _ -> :pop end)

    [
      Enum.map(operators, fn {operator, f} -> create(type, operator, f) end),
      if using != false do
        create__using_macro__macro(operators)
      end
    ]
  end

  defp create(type, _, _) when type not in [:def, :defmacro] do
    raise Error, "expected type to be :def or :defmacro but got #{type}."
  end

  defp create(_, operator, _) when operator in [:., :"=>", :^, :"not in", :when] do
    raise Error, "can't use #{operator}, because it is used by the Elixir parser."
  end

  defp create(type, operator, f) do
    arity = arity(f)
    operator_arities = arities(operator)

    cond do
      operator_arities == [] ->
        raise Error,
              "expected an operator but got #{operator}."

      arity not in operator_arities ->
        raise Error,
              "expected a function with arity in #{operator_arities}, but got arity #{arity}."

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

      defmacro unquote(operator)(a, b) do
        unquote(f).(a, b)
      end
    end
  end

  defp arity(f) do
    {f, _} = Code.eval_quoted(f)
    {:arity, arity} = Function.info(f, :arity)
    arity
  end

  defp arities(operator) do
    [1, 2] |> Enum.filter(fn arity -> Macro.operator?(operator, arity) end)
  end

  defp create__using_macro__macro(operators) do
    quote do
      defmacro __using__(_) do
        module = __MODULE__

        kernel_excludes =
          unquote(Enum.map(operators, fn {operator, f} -> {operator, arity(f)} end))

        quote do
          import Kernel, except: unquote(kernel_excludes)
          import unquote(module)
        end
      end
    end
  end
end
