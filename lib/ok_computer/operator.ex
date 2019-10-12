defmodule OkComputer.Operator do
  @moduledoc false

  def create_module(module, macro_sources) do
    Code.compile_string("""
      defmodule #{module} do
        #{Enum.join(macro_sources)}
      end
    """)
  end

  def defoperator(operator, f) do
    """
      defmacro lhs #{operator} rhs do
        quote do
          #{f.("lhs", "rhs")}
         end
      end
    """
  end
end
