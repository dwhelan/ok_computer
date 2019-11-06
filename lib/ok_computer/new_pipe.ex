defmodule OkComputer.NewPipe do
  @callback pipe?(any) :: boolean

  defmacro pipe(atom, module, function_name) do
    create(atom, module, function_name)
  end

  def create(atom, module, function_name) do
    alias OkComputer.{NewOperator, NewPipe}

    NewOperator.create_operator(
      atom,
      quote do
        NewPipe.operator_function(unquote(module), unquote(function_name))
      end,
      :operator_macro
    )
  end

  def operator_function(module, function_name) do
    fn left, right ->
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

  def pipe(a, f, module, function_name) do
    cond do
      module.pipe?(a) -> apply(module, function_name, [a, f])
      true -> a
    end
  end

  defmacro __using__(_) do
    quote do
      alias OkComputer.NewPipe
      import NewPipe

      @behaviour NewPipe
    end
  end
end
