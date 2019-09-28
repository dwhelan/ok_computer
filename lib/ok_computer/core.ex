defmodule OkComputer.Core do
  defmacro left ~> right do
    quote do
      value = unquote(left)

      case ok?(value) do
        true -> unquote(Macro.pipe(left, right, 0))
        false -> value
      end
    end
  end

  defmacro left ~>> right do
    quote do
      value = unquote(left)

      case ok?(value) do
        true -> value
        false -> unquote(Macro.pipe(left, right, 0))
      end
    end
  end

  defmacro foo do
    quote do
      import OkComputer.Core

      def error?(value), do: not ok?(value)
      @doc """
      Pipes ok values to case statements.

      If `value` is ok, then it will be pattern matched through the `case` statement and the result returned,
      otherwise `value` will be returned.

      This may be convenient as you don't need to create `case` clauses for error values.
      """
      defmacro case_ok(value, do: clauses) do
        quote do
          value = unquote(value)

          case ok?(value) do
            true ->
              case value do
                unquote(clauses)
              end

            false ->
              value
          end
        end
      end
    end
  end

  def case_ok2(value, do_clauses) do
    quote do
      value = unquote(value)

      case ok?(value) do
        true ->
          case value do
            unquote(do_clauses)
          end

        false ->
          value
      end
    end
  end
end
