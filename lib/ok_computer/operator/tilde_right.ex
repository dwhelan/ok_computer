defmodule OkComputer.Operator.TildeRight do
  def operator(f, 2) do
    quote do
      def left ~> right do
        unquote(f).(left, right)
      end
    end
  end

  def operator_macro(f, 2) do
    quote do
      defmacro left ~> right do
        unquote(f).(left, right)
      end
    end
  end
end
