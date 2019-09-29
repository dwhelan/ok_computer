defmodule OkComputer.OkNonNil do
  import OkComputer.Switch

  def ok_monad(), do: OkComputer.Monads.NonNil
  def error_monad(), do: OkComputer.Monads.Nil

  monadic_switch
end
