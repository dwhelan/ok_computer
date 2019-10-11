# OkComputer

because Radiohead

Allows you to pipe values through functions with filtering automatically applied.

For example:

```elixir
case result do
  {:ok, value} -> {:ok, to_string(value)}
  anything_else -> anything_else
end
```

```elixir
import OkComputer.Monad.Result
result ~> to_string()

``` 

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
- better error handling
  - check for duplicate pipe operators
