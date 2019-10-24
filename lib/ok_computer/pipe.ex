defmodule OkComputer.Pipe do
  @moduledoc """
  A bridge between binary operators and monads.
  """

  @doc """
  Inserts an operator function that calls a monadic function.

  The operator function generated for `:bind` and `Result` would be sort of like:
  ```
    def bind(left, right) do
      Result.bind(left, fn _ -> left |> right)
    end
  ```
  """
  @spec pipe({atom, module}) :: Macro.t()
  defmacro pipe({name, module}) do
    quote do
      @name unquote(name)
      @module unquote(module)

      def unquote(name)(left, right) do
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
