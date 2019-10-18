defmodule OkComputer.Operator do
  @moduledoc """
  Creates operators dynamically.

  You can easily define operators if you know in advance the operator you want to use:

  ```elixir
  defmodule WrongMath do
    # Let's make math wrong by changing the meaning of +:
    def a + b, do: a - b
  end
  ```

  If you want to make the operator dynamic then things are a little harder:

  ```elixir
  # This won't compile:
  op = :+
  def a op b, do: a - b
  end
  ```

  Operators are creating by embedding source code for each operator definition into a module, compiling the module and importing it.

  The source code is simply a string version of what you would provide for a macro.
  The AST for the left hand side of the operator is available as
  as `left` and the AST for the right hand side is available as `right`.

  We can now create a dynamic pipe:

  ```
  defmodule WrongMath do
    import OkComputer.Operator

    defoperators +: "unquote(left) - unquote(right)"
  end
  ```

  This is equivalent to:

  ```
  defmodule WrongMath do
    defmacro left + right do
      quote do
        unquote(left) - unquote(right)
      end
    end
  end
  ```
  """

  @doc """
  Builds a module with operators and imports it.

  The name of the module will be the caller's module concatenated with `Operators`.
  """
  @spec defoperators(keyword(binary)) :: Macro.t()
  defmacro defoperators(operators) do
    defoperators(operators, Module.concat(__CALLER__.module, Operators))
  end

  @doc """
  Builds a module with operators and returns the AST to import it.
  """
  @spec defoperators(keyword(binary), module) :: Macro.t()
  def defoperators(operators, module) do
    Code.compile_string("""
      defmodule #{module} do
        #{Enum.map(operators, &defoperator/1)}
      end
    """)

    quote do
      import unquote(module)
    end
  end

  defp defoperator({operator, source}) do
    """
      defmacro left #{operator} right do
        quote do
          #{source}
         end
      end
    """
  end

  defmacro operators(operators, name \\ Operators) do
    module = Module.concat(__CALLER__.module, name)

    Code.compile_string(~s[
      defmodule #{module} do
        #{create_operators(operators)}
      end
    ])

    quote do
      import unquote(module)
    end
  end

  def create_operators(operators) do
    Enum.map(operators, &create_operator/1)
  end

  def create_operator({atom, source}) when is_binary(source) do
    ~s[
      defmacro left #{atom} right do
        quote do
          #{source}
        end
      end
    ]
  end

  def create_operator({atom, {{:__aliases__, _, _} = alias, function_name} = capture}) do
    module = Macro.expand(alias, __ENV__)
    ~s[
      def left #{atom} right do
        #{module}.#{function_name}(left, right)
      end
    ]
  end

  def create_operator({atom, {:{}, _, [{:__aliases__, _, _} = alias, function_name, :macro]}}) do
    module = Macro.expand(alias, __ENV__)
    ~s[
      defmacro left #{atom} right do
        require #{module}
        #{module}.#{function_name}(left, right)
      end
    ]
  end

  def create_operator({atom, {:&, _, _} = f}) do
    ~s[
        def left #{atom} right do
          (#{Macro.to_string(f)}).(left, right)
        end
    ]
  end
end
