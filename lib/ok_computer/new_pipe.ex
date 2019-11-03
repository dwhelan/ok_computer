defmodule OkComputer.NewPipe do
  defmacro pipe(atom, module, function_name) do
    import OkComputer.NewOperator

    f = quote do
      module = unquote(module)
      function_name = unquote(function_name)

      fn left, right ->
        quote do
          unquote(module).unquote(function_name)(
            unquote(left),
            fn left ->
              left
              |> unquote(right)
            end
          )
        end
      end
    end
    create_operator(atom, f, :operator_macro)
  end

  @spec pipes(Macro.t(), atom | list(atom)) :: Macro.t()
  defmacro pipes(target, names) do
    target = Macro.expand(target, __CALLER__)
    module = module(target, __CALLER__)

    create(target, names, module)

    quote do
      import unquote(module)
    end
  end

  @spec create(module, atom | list(atom), module) :: {:module, module(), binary(), term()}
  def create(target, names, module) do
    names = List.wrap(names)

    Module.create(
      module,
      [
        module_doc(target, names),
        Enum.map(names, &create_operator_function(target, &1))
      ],
      Macro.Env.location(__ENV__)
    )
  end

  defp create_operator_function(target, name) do
    quote do
      @target unquote(target)
      @name unquote(name)

      require unquote(target)

      @doc "An operator function that calls #{@target}.#{@name}(left, fn _ -> left |> right)"
      def unquote(name)(left, right) do
        quote do
          unquote(@target).unquote(@name)(
            unquote(left),
            fn left ->
              left
              |> unquote(right)
            end
          )
        end
      end
    end
  end

  @spec module(module, Macro.Env.t()) :: module
  def module(target, env) do
    Module.concat(
      [
        env.module,
        Pipe,
        Module.split(target)
        |> List.last()
      ]
    )
  end

  defp module_doc(target, names) do
    quote do
      @moduledoc """
      Creates operator functions, #{Enum.join(unquote(names))}, that pipe via #{unquote(target)}.
      """
    end
  end
end
