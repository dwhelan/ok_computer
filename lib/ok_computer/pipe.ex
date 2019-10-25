defmodule OkComputer.Pipe do
  @moduledoc """
  A bridge between binary operators and monads.
  """

  @doc """
  Inserts an operator function that calls a monadic function.

  The operator function generated for `Result` and `:bind` would belike:
  ```
    def bind(left, right) do
      Result.bind(left, fn _ -> left |> right)
    end
  ```
  """
  @spec pipe(module, atom | list(atom)) :: Macro.t()
  defmacro pipe(module, function_names) do
    create_pipe_operators(module, List.wrap(function_names))
  end

  defmacro pipe_module(alias, function_names) do
    module = Macro.expand(alias, __CALLER__)
    create_pipe_module(module, List.wrap(function_names), Module.concat(__CALLER__.module, module))
  end

  def create_pipe_module(module, function_names, pipe_module) do
    code = create_pipe_operators(module, List.wrap(function_names))
    Module.create(pipe_module, code, Macro.Env.location(__ENV__))
    quote do
      import unquote(pipe_module)
    end
  end

  def create_pipe_operators(module, function_names) do
    Enum.map(function_names, fn function_name -> create_pipe_operator(module, function_name) end)
  end

  def create_pipe_operator(module, function_name) do
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

defmodule OkComputer.Pipes do
  @moduledoc """
  A bridge between binary operators and monads.
  """

  @doc """
  Creates a module of bridge functions.
  """
  @spec create(module, bindings :: keyword(module), Macro.Env.t() | keyword()) :: {:module, module(), binary(), term()}
  def create(module, names, opts) do
    require OkComputer.Pipe

    IO.inspect names: names

    code =
      quote do
        @module unquote(module)
        @names unquote(names)

        require unquote(module)

        Enum.map(unquote(names), fn name ->
          @name name

          def unquote(@name)(left, right) do
#            unquote(@module).unquote(@name)(left, fn left -> left |> unquote(right) end)
          end
        end)
      end

    IO.inspect source: Macro.to_string(code)
    Module.create(module, code, opts)
#    Module.create(module, Enum.map(bindings, &to_string/1), opts)
  end

  def pipe(module, name, left, right) do

  end
end
