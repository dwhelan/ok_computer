defmodule OkComputer.Operator do
  defmacro operator(atom, f) do
    create(atom, f, :def)
  end

  defmacro operator_macro(atom, f) do
    create(atom, f, :defmacro)
  end

  def create(atom, f, type) when atom in [:., :"=>", :"not in", :when] do
    raise OkComputer.OperatorError, atom
  end

  def create(atom, f, type) do
    operator(atom, f, arity(f), type)
  end

  defp operator(atom, f, 1, :def) do
    quote do
      import Kernel, except: [{unquote(atom), 1}]

      def unquote(atom)(input) do
        unquote(f).(input)
      end
    end
  end

  defp operator(atom, f, 2, :def) do
    quote do
      import Kernel, except: [{unquote(atom), 2}]

      def unquote(atom)(left, right) do
        unquote(f).(left, right)
      end
    end
  end

  defp operator(atom, f, 1, :defmacro) do
    quote do
      import Kernel, except: [{unquote(atom), 1}]

      defmacro unquote(atom)(input) do
        unquote(f).(input)
      end
    end
  end

  defp operator(atom, f, 2, :defmacro) do
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
