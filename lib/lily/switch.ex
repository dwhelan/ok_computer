defmodule OkComputer.Switch do
  @moduledoc """
  Support for creating switches.

  A switch consists of pipe and switch function that either uses or short circuits the pipe.
  """
  alias Lily.{Pipe, Function}
  require Lily.{Pipe, Function}
  alias Lily.Error

  @doc """
  Creates switches.
  """
  defmacro defswitches(switches) do
    create(switches, __CALLER__)
  end

  def create(switches, env) do
    Pipe.create(pipe_functions(switches, env), env)
  end

  defp pipe_functions(switches, env) do
    Enum.map(
      switches,
      fn {operator, {switch_fun, pipe_fun}} ->
        cond do
          Function.arity(switch_fun, env) != 2 ->
            raise Error,
                  "expected a switch function with arity 2 but it has arity #{
                    Function.arity(switch_fun, env)
                  }."

          true ->
            {operator, operator_function(switch_fun, pipe_fun)}
        end
      end
    )
  end

  defp operator_function(switch_fun, pipe_function) do
    quote do
      fn a, f ->
        pipe_function = unquote(pipe_function)

        quote do
          unquote(pipe_function).(unquote(a), fn a -> a |> unquote(f) end)
        end
      end
    end
  end
end
