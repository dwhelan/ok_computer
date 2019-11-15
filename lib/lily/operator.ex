defmodule Lily.Operator do
  @moduledoc """
  Creates operators using anonymous functions.

  You create an operator by calling `&operators/1` or `&defoperator_macros/1`
  with a keyword list of functions.
  These macros will insert a `:def` or `:defmacro` function called `name` into your module.

  When an operator is called the given function will be called with the operator arguments.
  """

  alias Lily.Error

  @doc """
  Creates operators.

  Insert operator functions for each operator given in `list`.
  The key is the operator name and the value is the function that the operator should call.

  ## Examples
  A complex math module:

  ```
  #{File.read!("test/support/complex.ex")}
  ```
        iex> use Complex
        iex> {1, 2} + {3, 4}
        {4, 6}
        iex> {1, 2} - {3, 4}
        {-2, -2}

  A `__using__` macro will be inserted that imports `Kernel`,
  except operators, and then imports itself.
  ## Examples
  """
  @spec defoperators(keyword(f :: Macro.t())) :: Macro.t()
  defmacro defoperators(list) do
    create(:def, list)
  end

  @doc """
  Creates operator macros.

  This will insert operator macros for each operator in `list`.
  The key is the operator name and the value is the function that the operator should call.

  ## Examples
  A `~>` operator that pipes `:ok` values and short circuits anything else.
  ```
  #{File.read!("test/support/ok_pipe.ex")}
  ```
        iex> use OkPipe
        iex> {:ok, :a} ~> to_string()
        {:ok, "a"}
        iex> :a ~> to_string()
        :a

  By default, a `__using__` macro will be inserted that imports `Kernel`,
  except operators, and then imports itself. If you don't want this
  include `{:__using__, false}` in `list`.
  """
  @spec defoperator_macros(keyword(f :: Macro.t())) :: Macro.t()
  defmacro defoperator_macros(list) do
    create(:defmacro, list)
  end

  @doc """
  Returns the AST to create an operator or an operator macro.

  This is useful if you would like to create your own macro that
  uses an operator or operator macro.

  If you want to create an operator function provide `:def` as the second argument
  along with the name of the operator and the function to call.

  If you want to create an operator macro provide `:defmacro` instead.

  ## Examples
  """
  @spec create(list, :def | :defmacro) :: Macro.t()
  def create(type, list) do
    {using, list} = Keyword.get_and_update(list, :__using__, fn _ -> :pop end)

    [
      Enum.map(list, fn {name, f} -> create(type, name, f) end),

      if using != false do
        create__using_macro__macro(list)
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
        kernel_excludes = unquote(Enum.map(operators, fn {operator, f} -> {operator, arity(f)} end))

        quote do
          import Kernel, except: unquote(kernel_excludes)
          import unquote(module)
        end
      end
    end
  end
end
