defmodule OkComputer.NewOperator do

  @operators %{
    @: At,
    ~>: TildeRight,
    ~>>: TildeRightRight
  }

  defmacro operator_macro(atom, f) do
    operator = Map.get(@operators, atom)
    operator.operator_macro(f)
  end

  defmodule At do
    def operator_macro(f) do
      quote do
        import Kernel, [except: [@: 1]]
        defmacro @ input do
          unquote(f).(input)
        end
      end
    end
  end

  defmodule TildeRight do
    def operator_macro(f) do
      quote do
        defmacro left ~> right do
          unquote(f).(left, right)
        end
      end
    end
  end

  defmodule TildeRightRight do
    def operator_macro(f) do
      quote do
        defmacro left ~>> right do
          unquote(f).(left, right)
        end
      end
    end
  end
end
