# OkComputer
Build multi-branch pipelines with custom operators, functions and even monads.  

The main property that we want with a pipeline is that each step should return a value.
If a step recognizes its input then it should operate on the input and return the result.
If a step does not recognize its input then it should simply return its input.

For a simple example, suppose we want a pipeline that operates on inputs like `{:ok, value}`.
If anything other than an`{:ok, value}` is given the step should simply return its input.
This lets us build a "happy path" pipeline where errors are short-circuited.

We could build steps like this using `case` expressions:

```elixir
defmodule Steps do
  def stringify(input) do
    case input do
      {:ok, value} -> {:ok, to_string(value)}
      anything_else -> anything_else
    end
  end

  def upcase(input) do
    case input do
      {:ok, value} -> {:ok, String.upcase(value)}
      anything_else -> anything_else
    end
  end
  
  # other steps ...
end
```

This does the job nicely:

    iex> import Steps

    iex> stringify({:ok, :value})
    {:ok, "value"}

    iex> stringify(:anything_else )
    :anything_else

We can use the standard pipe operator `|>` to connect steps into a pipeline:

    iex> {:ok, :value}
    ...>   |> stringify()
    ...>   |> upcase()
    {:ok, "VALUE"}
    
    iex> :anything_else
    ...>   |> stringify()
    ...>   |> upcase()
    :anything_else

One downside of this approach is that we have duplicated the `case` expression in each step.
Let's see how we could remove that duplication.
We could use a function like:
 
```elixir
defmodule Steps do
  def process(input, fun) do
    case input do
      {:ok, value} -> {:ok, fun.(value)}
      anything_else -> anything_else
    end
  end
end
```
Now we can build a pipeline like this:

    iex> import Steps
    
    iex> {:ok, :value} 
    ...>   |> process(fn value -> to_string(value) end)
    ...>   |> process(fn value -> String.upcase(value) end)
    {:ok, "VALUE"}
    
This is arguably better because we now have only one `case` expression.
But instead we have duplication within each step: `process(fn value -> ...(value) end)`.

What if we had a custom pipe operator that removed this duplication?
This is exactly what `Pipe.pipe` does.
You provide it a module and it will create a `~>` pipe operator.
The pipe operator calls `process` with an input and a function.

Now the pipeline looks like:

    iex> import OkComputer.Pipe

    iex> pipe Steps, ~>: :process
     
    iex> {:ok, :value} 
    ...>   ~> to_string()
    ...>   ~> String.upcase()
    {:ok, "VALUE"}
     
    iex> :anything_else 
    ...>   ~> to_string()
    ...>   ~> String.upcase()
    :anything_else
 
We now have a powerful pipe operator that we use to separate the processing steps
from the details of what is `ok` for those steps.

The `pipe` macro supports any binary operator that evaluates "left to right" (e.g. `~>`).
You also give a module (e.g. `Steps`) and the name of a function with arity 2 in that module (e.g. `:process`).
When a pipe is evaluated the input and an anonymous function will be given to the named function.
The anonymous function simply wraps whatever is to the right of the operator.

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
  - check for invalid functions (pipe_bind/2 pipe_fmap/2)
  - support unary operators (perhaps return_pipe?)
