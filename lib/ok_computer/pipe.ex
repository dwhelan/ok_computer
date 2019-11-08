defmodule OkComputer.Pipe do
  @callback pipe?(any) :: boolean

  defmacro pipe(atom, module, function_name) do
    create(atom, module, function_name)
  end

  def create(atom, pipe, function_name) do
    OkComputer.Operator.create(atom, operator_function(pipe, function_name), :defmacro)
  end

  defp operator_function(pipe, function_name) do
    quote do
      fn left, right ->
        pipe = unquote(pipe)
        function_name = unquote(function_name)

        quote do
          pipe(
            unquote(left),
            fn left -> left |> unquote(right) end,
            unquote(pipe),
            unquote(function_name)
          )
        end
      end
    end
  end

  def pipe(a, f, pipe, function_name) do
    case pipe.pipe?(a) do
      true -> apply(pipe, function_name, [a, f])
      _ -> a
    end
  end
end
