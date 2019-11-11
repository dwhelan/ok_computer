defmodule OkComputer.Operator do
  @moduledoc """
  Creates operators using anonymous functions.

  """

  @doc """
  Creates an operator.
  """
  @spec operator(atom, Macro.t()) :: Macro.t()
  defmacro operator(atom, f) do
    create(:def, atom, f)
  end

  @doc """
  Creates an operator macro.
  """
  @spec operator_macro(atom, Macro.t()) :: Macro.t()
  defmacro operator_macro(atom, f) do
    create(:defmacro, atom, f)
  end

  @doc """
  Returns the AST to create an operator or an operator macro.
  """
  @spec create(:def | :defmacro, atom, Macro.t()) :: Macro.t()
  def create(_, atom, _) when atom in [:., :"=>", :^, :"not in", :when] do
    raise OkComputer.OperatorError,
          "cannot create an operator for #{atom}, because it is used by the Elixir parser."
  end

  def create(type, atom, f) when type in [:def, :defmacro] do
    operator(type, atom, f, arity(f))
  end

  defp operator(:def, atom, f, 1) do
    quote do
      import Kernel, except: [{unquote(atom), 1}]

      def unquote(atom)(input) do
        unquote(f).(input)
      end
    end
  end

  defp operator(:def, atom, f, 2) do
    quote do
      import Kernel, except: [{unquote(atom), 2}]

      def unquote(atom)(left, right) do
        unquote(f).(left, right)
      end
    end
  end

  defp operator(:defmacro, atom, f, 1) do
    quote do
      import Kernel, except: [{unquote(atom), 1}]

      defmacro unquote(atom)(input) do
        unquote(f).(input)
      end
    end
  end

  defp operator(:defmacro, atom, f, 2) do
    quote do
      import Kernel, except: [{unquote(atom), 2}]

      defmacro unquote(atom)(left, right) do
        unquote(f).(left, right)
      end
    end
  end

  defp arity(f) do
    {f, _} = Code.eval_quoted(f)
    {:arity, arity} = Function.info(f, :arity)
    arity
  end
end
