defmodule Lily.Operator do
  @moduledoc """
  Creates funny operators.

  You create an operator by calling `&operator2/1` or `&operator_macro2/1` with a `name` and a `function`.
  These macros will insert a `:def` or `:defmacro` function called `name` into your module.
  The created function simply calls `function` with its input args.
  """

  alias Lily.OperatorError

  @doc """
  Creates operators.

  ## Examples
  For example, you might want to use complex math operators:

  ```
  #{File.read!("test/support/complex.ex")}
  ```

        iex> use Complex
        iex> {1, 2} + {3, 4}
        {4, 6}
        iex> {1, 2} - {3, 4}
        {-2, -2}

  """
  @spec operators(atom, list) :: Macro.t()
  defmacro operators(list) do
    operators(:def, list)
  end

  defp operators(type, list) do
    [
      Enum.map(list, fn {name, f} -> create(type, name, f) end),
      create_using_macro(list)
    ]
  end

  defp create_using_macro(list) do
    quote do
      defmacro __using__(_) do
        module = __MODULE__
        operators = unquote(Enum.map(list, fn {name, f} -> {name, arity(f)} end))

        quote do
          import Kernel, except: unquote(operators)
          import unquote(module)
        end
      end
    end
  end

  @doc """
  Creates operator macros.


  """
  @spec operator_macros(list) :: Macro.t()
  defmacro operator_macros(list) do
    operators(:defmacro, list)
  end

  @doc """
  Returns the AST to create an operator or an operator macro.
  """
  @spec create(:def | :defmacro, atom, Macro.t()) :: Macro.t()
  def create(type, _, _) when type not in [:def, :defmacro] do
    raise OperatorError, "expected type to be :def or :defmacro but got #{type}."
  end

  def create(_, name, _) when name in [:., :"=>", :^, :"not in", :when] do
    raise OperatorError, "can't use #{name}, because it is used by the Elixir parser."
  end

  def create(type, name, f) do
    arity = arity(f)
    operator_arities = operator_arities(name)

    cond do
      operator_arities == [] ->
        raise OperatorError,
              "expected an operator but got #{name}."

      arity not in operator_arities ->
        raise OperatorError,
              "expected a function with arity in #{operator_arities}, but got arity #{arity}."

      true ->
        operator(type, name, f, arity)
    end
  end

  defp operator(:def, name, f, 1) do
    quote do
      import Kernel, except: [{unquote(name), 1}]

      def unquote(name)(a) do
        unquote(f).(a)
      end
    end
  end

  defp operator(:def, name, f, 2) do
    quote do
      import Kernel, except: [{unquote(name), 2}]

      def unquote(name)(a, b) do
        unquote(f).(a, b)
      end
    end
  end

  defp operator(:defmacro, name, f, 1) do
    quote do
      import Kernel, except: [{unquote(name), 1}]

      defmacro unquote(name)(a) do
        unquote(f).(a)
      end
    end
  end

  defp operator(:defmacro, name, f, 2) do
    quote do
      import Kernel, except: [{unquote(name), 2}]

      defmacro unquote(name)(a, b) do
        unquote(f).(a, b)
      end
    end
  end

  defp arity(f) do
    {f, _} = Code.eval_quoted(f)
    {:arity, arity} = Function.info(f, :arity)
    arity
  end

  def operator_arities(name) do
    [1, 2] |> Enum.filter(fn arity -> Macro.operator?(name, arity) end)
  end
end
