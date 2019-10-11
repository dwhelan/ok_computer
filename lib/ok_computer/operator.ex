defmodule OkComputer.Operator do
  @moduledoc false

  def create_module(macro_sources, module) do
    Code.compile_string("""
      defmodule #{module} do
        #{Enum.join(macro_sources)}
      end
    """)
  end

  def macro_source(operator, alias, function, env) do
    """
      defmacro lhs #{operator} rhs do
        quote do
          #{Macro.expand(alias, env)}.#{function}(unquote(lhs), fn a -> a |> unquote(rhs) end)
         end
      end
    """
  end
end
