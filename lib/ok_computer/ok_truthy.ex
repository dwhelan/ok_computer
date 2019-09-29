defmodule OkComputer.OkTruthy do
  import OkComputer.Switch

  def ok_monad(), do: OkComputer.Monads.Truthy
  def error_monad(), do: OkComputer.Monads.Falsey

  monadic_switch
end
