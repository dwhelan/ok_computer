defmodule OkComputer.NewPipe do
  defmacro pipe(atom, module, function_name) do
    create(atom, module, function_name)
  end

  def create(atom, module, function_name) do
    operator_function =
      quote do
        OkComputer.NewPipe.operator_function(
          unquote(module),
          unquote(function_name)
        )
      end

    OkComputer.NewOperator.create_operator(atom, operator_function, :operator_macro)
  end

  def operator_function(module, function_name) do
    fn left, right ->
      operator_function =
        quote do
          module = unquote(module)
          function_name = unquote(function_name)
          left = unquote(left)

          cond do
            module.pipe?(left) ->
              apply(module, function_name, [
                left,
                fn left -> left |> unquote(right) end
              ])

            true ->
              left
          end
        end
    end
  end
end
