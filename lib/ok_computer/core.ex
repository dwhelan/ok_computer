defmodule OkComputer.Core do
  def ok_pipe(left, right) do
    quote do
      value = unquote(left)

      case ok?(value) do
        true -> unquote(Macro.pipe(left, right, 0))
        false -> value
      end
    end
  end

  def error_pipe(left, right) do
    quote do
      value = unquote(left)

      case ok?(value) do
        true -> value
        false -> unquote(Macro.pipe(left, right, 0))
      end
    end
  end

  def case_ok(value, do_clauses) do
    quote do
      value = unquote(value)

      case ok?(value) do
        true ->
          case value do
            unquote(do_clauses)
          end

        false -> value
      end
    end
  end
end
