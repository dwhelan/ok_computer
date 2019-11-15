defmodule Lily.Operator do
  @moduledoc """
  Creates operators using anonymous functions.

  You create an operator by calling `&operators/1` or `&operator_macros/1`
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
  @spec operators(keyword(f :: Macro.t())) :: Macro.t()
  defmacro operators(list) do
    operators(:def, list)
  end

  @doc """
  Creates operator macros.

  This will insert operator macros for each operator given in `list`.
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

  A `__using__` macro will be inserted that imports `Kernel`,
  except operators, and then imports itself.
  """
  @spec operator_macros(keyword(f :: Macro.t())) :: Macro.t()
  defmacro operator_macros(list) do
    operators(:defmacro, list)
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
        kernel_excludes = unquote(Enum.map(list, fn {name, f} -> {name, arity(f)} end))

        quote do
          import Kernel, except: unquote(kernel_excludes)
          import unquote(module)
        end
      end
    end
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
  def create(list, type) do
    [
      Enum.map(list, fn {name, f} -> create(type, name, f) end),
      case Keyword.get(list, :__using__, true) do
        true -> create_using_macro(list)
        _ -> nil
      end
    ]
  end

  def create(type, _, _) when type not in [:def, :defmacro] do
    raise Error, "expected type to be :def or :defmacro but got #{type}."
  end

  def create(_, name, _) when name in [:., :"=>", :^, :"not in", :when] do
    raise Error, "can't use #{name}, because it is used by the Elixir parser."
  end

  def create(_, :create__using__, true) do
  end

  def create(_, :create__using__, _) do
  end

  def create(type, name, f) do
    arity = arity(f)
    operator_arities = operator_arities(name)

    cond do
      operator_arities == [] ->
        raise Error,
              "expected an operator but got #{name}."

      arity not in operator_arities ->
        raise Error,
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
