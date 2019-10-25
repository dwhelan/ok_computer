defmodule OkComputer.Pipe do
  @moduledoc """
  Builds operator functions that operate as pipes.

  A pipe operator function is an operator function that calls another function
  with two arguments. The first argument is the left input to the binary operator. The second
  argument is a function that pipes the left input into the right input.
  The other function is specified with a `module` and a `function_name`.
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
  @spec pipe(module, atom | list(atom)) :: Macro.t()
  defmacro pipe(alias, function_names) do
    module = Macro.expand(alias, __CALLER__)

    create_pipe_module(
      module,
      List.wrap(function_names),
      Module.concat(__CALLER__.module, module)
    )
  end

  def create_pipe_module(module, function_names, pipe_module) do
    Module.create(
      pipe_module,
      create_pipe_operator_functions(module, List.wrap(function_names)),
      Macro.Env.location(__ENV__)
    )

    quote do
      import unquote(pipe_module)
    end
  end

  def create_pipe_operator_functions(module, function_names) do
    Enum.map(function_names, fn function_name ->
      create_pipe_operator_function(module, function_name)
    end)
  end

  def create_pipe_operator_function(module, function_name) do
    quote do
      require unquote(module)

      @name unquote(function_name)
      @module unquote(module)

      def unquote(function_name)(left, right) do
        quote do
          unquote(@module).unquote(@name)(unquote(left), fn left -> left |> unquote(right) end)
        end
      end
    end
  end
end
