# OkComputer
Supports railway programming using pipes.

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

- `Switch` properties:
  - for any value one and only one of its monads should fire
  - is a monad via delegation
    - switch decides which monad to delegate to
      
- `Operator` properties:
  - has a `build` macro that returns a macro bound to the input monad.
    When that macro is called it will call `monad.bind()` passing a function
    that operates on the value. 
    How that operation is defined is up to each operator   

## To do
- move `wrap` responsibility to `Switch`
- update Switch to include fmap and remove Operations
  - `build Ok: :~>, Error: :<~ # builds fmap only pipes`
  - `build Ok: {:~>, :~>>}, Error: {:<~, :<<~} # builds fmap and bind pipes`
  - `build Ok, Error # builds standard pipes`
- create `case_m value, monad` macro?
- Create Pipe operations and simply have operators delegate to it
- A switch is an n-ary monad
- use string compilation to pass ok_monad and monad_error directly into the code (avoid module attributes)
- use `Eex` to build operators
- better error handling
  - Switch.build with no operations or pipes `build [Value, Nil]`
  - check for duplicate pipe operators
- remove duplication with creating pipes. Something like:
```elixir
    source = """
      defmacro left <%= pipe %> right do
        quote do
          <%= monad %>.bind(unquote(left), fn _ -> unquote(Macro.pipe(left, right, 0)) end)
        end
      end
    """
    EEx.eval_string(source, pipe: pipe, monad: monad)

    # This does not work, considered creating a module with the macro but seems too complicated    
    source = """
      <%=
      defmacro lhs ~> rhs do
        quote do
          OkComputer.Monad.Value.fmap(unquote(lhs), fn a -> a |> unquote(rhs) end)
        end
      end
      %>
    """

    EEx.eval_string(source) #, module: module, function: function)
    
```
Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/ok_computer](https://hexdocs.pm/ok_computer).
