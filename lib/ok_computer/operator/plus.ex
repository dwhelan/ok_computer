defmodule OkComputer.NewOperator.Plus do
    def arity(), do: [1, 2]

    def operator(f, 1) do
      quote do
        import Kernel, except: [+: 1]

        def +input do
          unquote(f).(input)
        end
      end
    end

    def operator(f, 2) do
      quote do
        import Kernel, except: [+: 2]

        def left + right do
          unquote(f).(left, right)
        end
      end
    end

    def operator_macro(f, 1) do
      quote do
        import Kernel, except: [+: 1]

        defmacro +input do
          unquote(f).(input)
        end
      end
    end

    def operator_macro(f, 2) do
      quote do
        import Kernel, except: [+: 2]

        defmacro left + right do
          unquote(f).(left, right)
        end
      end
    end
end
