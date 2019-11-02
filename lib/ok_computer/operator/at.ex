defmodule OkComputer.NewOperator.At do
  def operator(f, 1) do
    quote do
      import Kernel, except: [@: 1]

      def @input do
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
