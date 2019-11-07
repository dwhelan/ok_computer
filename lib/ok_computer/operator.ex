defmodule OkComputer.Operator do
  @operators %{
    @: At,
    +: Plus,
    ~>: TildeRight,
    ~>>: TildeRightRight
  }

  defmacro operator(atom, f) do
    create(atom, f, :operator)
  end

  defmacro operator_macro(atom, f) do
    create(atom, f, :operator_macro)
  end

  def create(atom, f, create_function) do
    operator = Module.concat(__MODULE__, Map.get(@operators, atom))
    operator_arities = operator_arities(atom)
    arity = arity(f)

    if arity in operator_arities do
      apply(operator, create_function, [f, arity])
    else
      raise "expected a function with arity in #{inspect(operator_arities)}, but got a function with arity #{
              arity
            }"
    end
  end

  defmacro operator2(atom, f) do
    create2(atom, f, :def)
  end

  defmacro operator_macro2(atom, f) do
    create2(atom, f, :defmacro)
  end

  def create2(atom, f, type) do
    if arity(f) in operator_arities(atom) do
      operator(atom, f, arity(f), type)
    else
      raise "expected a function with arity in #{inspect(operator_arities(atom))}, but got a function with arity #{
              arity(f)
            }"
    end
  end

  def operator(atom, f, 1, :def) do
    quote do
      import Kernel, except: [{unquote(atom), 1}]

      def unquote(atom)(input) do
        unquote(f).(input)
      end
    end
  end

  def operator(atom, f, 2, :def) do
    quote do
      import Kernel, except: [{unquote(atom), 2}]

      def unquote(atom)(left, right) do
        unquote(f).(left, right)
      end
    end
  end

  def operator(atom, f, 1, :defmacro) do
    quote do
      import Kernel, except: [{unquote(atom), 1}]

      defmacro unquote(atom)(input) do
        unquote(f).(input)
      end
    end
  end

  def operator(atom, f, 2, :defmacro) do
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

  def operator_arities(atom) do
    [1, 2] |> Enum.filter(fn arity -> Macro.operator?(atom, arity) end)
  end
end
