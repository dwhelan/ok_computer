# OkComputer
Builds multi-branch pipelines.  

Elixir pipes made monadic.  

About the name `OkComputer` ... Radiohead.

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
- leverage properties/laws
- retain Elixir pipe behaviour on the right hand side of the pie

## To do
- implement tri/multi channel
- should not import over-ridden Kernel operators 
- pipe wrappers for other monads (protocol?)
- implement applicatives
- other monads: reader, writer, state ...
- build a 'do' or `for` that has `when` behaviour with monadic values
- better error handling
  - check for duplicate pipe operators
