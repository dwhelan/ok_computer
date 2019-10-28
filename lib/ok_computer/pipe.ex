defmodule OkComputer.Pipe do
  @moduledoc """
  Creates pipe that can be used with operators.


  ## Pipe functions
  Pipe functions are used to conditionally

  They takes two arguments.
  The first is the left input to a binary operator macro.
  The second is a function that pipes the left input into the right input.
  The pipe function will return the value returned by the function.
  """

  @doc """
  Inserts an operator function that that pipes the left hand side into the right hand side..

  The operator function generated for `Result` and `:bind` would belike:
  ```
    def bind(left, right) do
      Result.bind(left, fn _ -> left |> right)
    end
  ```
  """
  @spec pipes(Macro.t(), atom | list(atom)) :: Macro.t()
  defmacro pipes(target, function_names) do
    target = Macro.expand(target, __CALLER__)
    module = module(target, __CALLER__)

    create(target, function_names, module)

    quote do
      import unquote(module)
    end
  end

  @spec create(module, atom | list(atom), module) :: {:module, module(), binary(), term()}
  def create(target, function_names, module) do
    function_names = List.wrap(function_names)

    Module.create(
      module,
      [
        module_doc(target, function_names),
        Enum.map(function_names, &create_operator_function(target, &1))
      ],
      Macro.Env.location(__ENV__)
    )
  end

  defp create_operator_function(target, function_name) do
    quote do
      @target unquote(target)
      @function_name unquote(function_name)

      require unquote(target)

      @doc "An operator function that calls #{@target}.#{@function_name}(left, fn _ -> left |> right)"
      def unquote(function_name)(left, right) do
        quote do
          unquote(@target).unquote(@function_name)(unquote(left), fn left ->
            left |> unquote(right)
          end)
        end
      end
    end
  end

  @spec module(module, Macro.Env.t()) :: module
  def module(target, env) do
    Module.concat([env.module, Pipe, Module.split(target) |> List.last()])
  end

  defp module_doc(target, function_names) do
    quote do
      @moduledoc """
      Creates operator functions, #{Enum.join(unquote(function_names))}, that pipe via #{
        unquote(target)
      }.
      """
    end
  end
end
