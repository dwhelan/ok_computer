# OkComputer

A library to simplify conditional logic and error handling.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ok_computer` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ok_computer, "~> 0.1.0"}
  ]
end
```

## To do
- `ok_tuple`
  - for `case` clauses; for each clause
      replace ast `{:<-, _, [left, right]}` with
                  `{:<-, _, [{:ok, left}, right]}`
                  
      in general: `{:<-, _, [left, right]}` with
                  `{:<-, _, [monad.return(left}, right]}`
- rename monad_ok to monad_ok
- switch() macro should create a module instead of injecting functions
- A switch is an n-ary monad
- use macros to build Switches like
  ```elixir
  defmacro build_switch([ok: monad_ok, error: monad_error], [Case, Pipe]) do
    # in a loop
    quote do
      def unquote("return_#{key}")(a, f) do
        unquote(value).return(a, f)
      end
    
      def unquote("bind_#{key}")(a, f) do
        unquote(value).bind(a, f)
      end
    end
  end
  ```                  
- this can be extended to build operations
  ```elixir
  defmacro build_operation(name, switch, do: block) do
    block = quote do
      
    end
    switch_name =  Macro.camelize "#{name}"
     Module.create(:"#{__MODULE__}.#{switch_name}", block, Macro.Env.location(__ENV__))
   
    quote do
      
    end
  end
  ``` 
- use string compilation to pass ok_monad and monad_error directly into the code (avoid module attributes)
Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/ok_computer](https://hexdocs.pm/ok_computer).
