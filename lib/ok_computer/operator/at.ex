defmodule OkComputer.Operator.At do
  def operator(f, 1) do
    operator(:@, f, 1)
  end

  def operator(atom, f, 1) do
    quote do
      import Kernel, except: [{unquote(atom), 1}]

      def unquote(atom)(input) do
        unquote(f).(input)
      end
    end
  end

  def operator_macro(f, 1) do
    quote do
      import Kernel, except: [@: 1]

      defmacro @input do
        unquote(f).(input)
      end
    end
  end
end
