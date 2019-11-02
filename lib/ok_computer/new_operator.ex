defmodule OkComputer.NewOperator do
  defmodule Plus do
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

  defmodule At do
    def operator_macro(f, 1) do
      quote do
        import Kernel, except: [@: 1]

        defmacro @input do
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
    @: {At, 1},
    +: {Plus, [1, 2]},
    ~>: {TildeRight, 2},
    ~>>: {TildeRightRight, 2}
  }

  defmacro operator_macro(atom, f) do
    {operator, operator_arity} = Map.get(@operators, atom)

    if function_arity(f) in List.wrap(operator_arity) do
      operator.operator_macro(f, function_arity(f) )
    else
      raise "expected a function with arity in #{inspect List.wrap(operator_arity)}, but got a function with arity #{function_arity(f)}"
    end
  end

  defp function_arity(f) do
    {f, _} = Code.eval_quoted(f)
    {:arity, arity} = Function.info(f, :arity)
    arity
  end

  defp operator_arities(arities) do
    List.wrap(arities)
  end
end
