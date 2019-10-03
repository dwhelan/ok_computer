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

## Principles
- minimilistic
- composable
- clear abstractions expressed as `@behaviours`: Switch, Pipe, Operation, Monad 
- should have properties for each `@behaviour` (<- property based testing)
- developer friendly: e.g. provide functions that validate Switch, Pipe, Operation, Monad properties

## To do
- move `wrap` responsibility to `Switch`
- `ok` case
  - for `case` clauses; for each clause
      replace ast `{:<-, _, [left, right]}` with
                  `{:<-, _, [{:ok, left}, right]}`
                  
      in general: `{:<-, _, [left, right]}` with
                  `{:<-, _, [monad.return(left}, right]}`
- allow setting of operators to use:
  ```elixir
  @spec build(keyword()) :: Macro.t
  defmacro build_monads(monads) do
  end

  build_monads ok: Ok, error: Error
  build_monads ok: {Ok, :~>}, error: Error

  build_operations [Pipe, Case]

  switch [Pipe, Case], ok: {Ok, :~>}, error: {Error, :"->>"}
  switch ok: {Ok, :~>}, error: {Error, :"->>"} # defaults operations
  ```
- `Switch` properties:
  - for any value one and only one of its monads should fire
  

- `Operator` properties:
  - has a `build` macro that returns a macro bound to the input monad.
    When that macro is called it will call `monad.bind()` passing a function
    that operates on the value. 
    How that operation is defined is up to each operator   
- Create Pipe operations and simply have operators delegate to it
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
