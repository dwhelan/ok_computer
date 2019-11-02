defmodule OkComputer.NewOperator do

  defmodule Plus do
    def operator_macro(f, 2) do
      quote do
        import Kernel, [except: [+: 2]]
        defmacro left + right do
          unquote(f).(left, right)
        end
      end
    end
  end

  defmodule At do
    def operator_macro(f, _) do
      quote do
        import Kernel, [except: [@: 1]]
        defmacro @ input do
          unquote(f).(input)
        end
      end
    end
  end

  defmodule TildeRight do
    def operator_macro(f, 2) do
      quote do
        defmacro left ~> right do
          unquote(f).(left, right)
        end
      end
    end
  end

  defmodule TildeRightRight do
    def operator_macro(f, 2) do
      quote do
        defmacro left ~>> right do
          unquote(f).(left, right)
        end
      end
    end
  end

  @operators %{
    @: At,
    +: Plus,
    ~>: TildeRight,
    ~>>: TildeRightRight
  }

  defmacro operator_macro(atom, f) do
    operator = Map.get(@operators, atom)
    operator.operator_macro(f, 2)
  end
end
