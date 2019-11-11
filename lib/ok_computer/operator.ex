defmodule OkComputer.Operator do
  @moduledoc """
  Creates operators using anonymous functions.

  """

  @doc """
  Creates an operator. 

  ```
  # comment
  #{File.read!("test/ok_computer/operator/complex_test.exs")}
  ```
  """
  defmacro operator(atom, f) do
    create(:def, atom, f)
  end

  defmacro operator_macro(atom, f) do
    create(:defmacro, atom, f)
  end

  def create(_, atom, _) when atom in [:., :"=>", :^, :"not in", :when] do
    raise OkComputer.OperatorError, atom
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

  def arity2(f) do
    {f, _} = Code.eval_quoted(f)
    {:arity, arity} = Function.info(f, :arity)
    arity
  end

  def arity(f) do
    {f, _} = Code.eval_quoted(f)
    {:arity, arity} = Function.info(f, :arity)
    arity
  end
end
