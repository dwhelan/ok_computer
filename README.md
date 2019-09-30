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
- type specs
- `ok_tuple`
  - for `case` clauses; for each clause
      replace ast `{:<-, _, [left, right]}` with
                  `{:<-, _, [{:ok, left}, right]}`
                  
      in general: `{:<-, _, [left, right]}` with
                  `{:<-, _, [monad.return(left}, right]}`

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/ok_computer](https://hexdocs.pm/ok_computer).
