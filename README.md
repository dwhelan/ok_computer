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
- retain Elixir pipe behaviour

## To do
- provide Module
- should not import over-ridden Kernel operators
- validate source provided to Operator
  - currently it silently fails if incorrect
- pipe wrappers for other monads (protocol?)
- implement applicatives
- other monads: reader, writer, state ...
- move laws to lib folder rather than test folder
- build a 'do' or `for` that has `when` behaviour with monadic values
- create pipe laws assuming for P
  - `~> === P.pipe_fmap`
  - `~>> === P.pipe_bind`  
  - `<~> === P.pipe_return`
  - left identity
    `a |> P.pipe_return |> P.pipe_bind(f) == f.(a)` ?
    `~~~ a ~>> f' == f'(a)` ?
  - right identity
    `a |> P.pipe_bind(&P.pipe_return/1) == a` ?
    `~~~ a == a` ?
  - associativity
    `a |> P.pipe_bind(f) |> P.pipe_bind(g) == a|> P.pipe_bind()  `
- operators
  - check for unique pipe operators
  - check for invalid functions (arity 2)
  - support unary operators (perhaps return_pipe?)
