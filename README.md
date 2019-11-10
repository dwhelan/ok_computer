# OkComputer
Creates operators with anonymous functions.

About the name `OkComputer`? ... Radiohead.

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
- pipe wrappers for other monad libraries (Witchcraft, MonadEx, OK ... protocol?)
- test applicatives
- add applicative pipes `>>>`, `<<<`?
- other monads: reader, writer, state ...
- move laws to lib folder rather than test folder
- build a 'do' or `for` that has `when` behaviour with monadic values
- create pipe laws
  - returns input if input is not in M ()
- operators
  - check for valid pipe operators (binary and left-to-right) or generalize to named functions/macros
  - support n-ary operators
