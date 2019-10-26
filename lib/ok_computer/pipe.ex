defmodule OkComputer.Pipe do
  @moduledoc """
  Builds pipe functions that can be used with operators.

  A pipe function is an operator function that calls another function with two arguments.
  The function is specified with a `module` and a `function_name`.
  The first argument given is the left input to the binary operator.
  The second argument given is a function that pipes the left input into the right input.
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
  defmacro pipes(alias, function_names) do
    module = Macro.expand(alias, __CALLER__)
    pipe_module = Module.concat(__CALLER__.module, module)

    create_pipe_module(module, List.wrap(function_names), pipe_module)
  end

  def create_pipe_module(module, function_names, pipe_module) do
    Module.create(
      pipe_module,
      Enum.map(function_names, fn function_name ->
        quote do
          require unquote(module)

          @module unquote(module)
          @name unquote(function_name)

          def unquote(function_name)(left, right) do
            quote do
              unquote(@module).unquote(@name)(unquote(left), fn left -> left |> unquote(right) end)
            end
          end
        end
      end),
      Macro.Env.location(__ENV__)
    )

    quote do
      import unquote(pipe_module)
    end
  end
end
