defmodule OkComputer.Pipe do
  @callback pipe?(any) :: boolean

  defmacro pipe(atom, module, function_name) do
    create(atom, module, function_name)
  end

  def create(atom, module, function_name) do
    OkComputer.Operator.create(atom, operator_function(module, function_name), :operator_macro)
  end

  def operator_function(module, function_name) do
    quote do
      fn left, right ->
        module = unquote(module)
        function_name = unquote(function_name)

        quote do
          pipe(
            unquote(left),
            fn left -> left |> unquote(right) end,
            unquote(module),
            unquote(function_name)
          )
        end
      end
    end
  end

  def pipe(a, f, module, function_name) do
    case module.pipe?(a) do
      true -> apply(module, function_name, [a, f])
      _ -> a
    end
  end
end
