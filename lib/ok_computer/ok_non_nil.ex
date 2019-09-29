defmodule OkComputer.OkNonNil do
  import OkComputer.Railroad
  alias OkComputer.Monads.{NonNil, Nil}

  def ok_monad(), do: NonNil
  def error_monad(), do: Nil

  defrailroad
end
