defmodule OkComputer.Core do

  def case_ok(value, do_clauses, module) do
    quote do
      value = unquote(value)

      case unquote(module).ok?(value) do
        true ->
          case value do
            unquote(do_clauses)
          end

        false -> value
      end
    end
  end
end
