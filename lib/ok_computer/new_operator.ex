defmodule OkComputer.NewOperator do
  defmodule Plus do
    def arity(), do: [1, 2]

    def operator(f, 1) do
      quote do
        import Kernel, except: [+: 1]

        def +input do
          unquote(f).(input)
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

  defmodule At do
    def arity(), do: [1]

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
    def arity(), do: [2]

    def operator_macro(f, 2) do
      quote do
        defmacro left ~> right do
          unquote(f).(left, right)
        end
      end
    end
  end

  defmodule TildeRightRight do
    def arity(), do: [2]

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

  defmacro operator(atom, f) do
    create_operator(atom, f, :operator)
  end

  defmacro operator_macro(atom, f) do
    create_operator(atom, f, :operator_macro)
  end

  defp create_operator(atom, f, create_function) do
    operator = Map.get(@operators, atom)
    arity = function_arity(f)

    if arity in operator.arity() do
      apply(operator, create_function, [f, arity])
    else
      raise "expected a function with arity in #{inspect(operator.arity())}, but got a function with arity #{
              arity
            }"
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
