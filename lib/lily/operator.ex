defmodule Lily.Operator do
  @moduledoc """
  Creates funny operators.

  """

  alias Lily.OperatorError

  @doc """
  Creates an operator.
  """
  @spec operator(atom, Macro.t()) :: Macro.t()
  defmacro operator(atom, f) do
    create(:def, atom, f)
  end

  @doc ~S"""
  Creates an operator macro.

  iex> use Lily.Complex
  iex> import Kernel, except: [+: 2, -: 2]
  iex> {1, 2} + {3, 4}
  {4, 6}
  iex> {1, 2} - {3, 4}
  {-2, -2}

  """
  @spec operator_macro(atom, Macro.t()) :: Macro.t()
  defmacro operator_macro(atom, f) do
    create(:defmacro, atom, f)
  end

  @doc """
  Returns the AST to create an operator or an operator macro.
  """
  @spec create(:def | :defmacro, atom, Macro.t()) :: Macro.t()
  def create(type, _, _) when type not in [:def, :defmacro] do
    raise OperatorError, "expected type to be :def or :defmacro but got #{type}."
  end

  def create(_, atom, _) when atom in [:., :"=>", :^, :"not in", :when] do
    raise OperatorError, "can't use #{atom}, because it is used by the Elixir parser."
  end

  def create(type, atom, f) do
    arity = arity(f)
    operator_arities = operator_arities(atom)

    cond do
      operator_arities == [] ->
        raise OperatorError,
              "expected an operator but got #{atom}."

      arity not in operator_arities ->
        raise OperatorError,
              "expected a function with arity in #{operator_arities}, but got arity #{arity}."

      true ->
        operator(type, atom, f, arity)
    end
  end

  defp operator(:def, atom, f, 1) do
    quote do
      import Kernel, except: [{unquote(atom), 1}]

      def unquote(atom)(a) do
        unquote(f).(a)
      end
    end
  end

  defp operator(:def, atom, f, 2) do
    quote do
      import Kernel, except: [{unquote(atom), 2}]

      def unquote(atom)(a, b) do
        unquote(f).(a, b)
      end
    end
  end

  defp operator(:defmacro, atom, f, 1) do
    quote do
      import Kernel, except: [{unquote(atom), 1}]

      defmacro unquote(atom)(a) do
        unquote(f).(a)
      end
    end
  end

  defp operator(:defmacro, atom, f, 2) do
    quote do
      import Kernel, except: [{unquote(atom), 2}]

      defmacro unquote(atom)(a, b) do
        unquote(f).(a, b)
      end
    end
  end

  defp arity(f) do
    {f, _} = Code.eval_quoted(f)
    {:arity, arity} = Function.info(f, :arity)
    arity
  end

  def operator_arities(atom) do
    [1, 2] |> Enum.filter(fn arity -> Macro.operator?(atom, arity) end)
  end
end
