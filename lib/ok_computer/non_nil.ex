defmodule OkComputer.NonNil do
  import OkComputer.Switch
  alias OkComputer.Monads.{NonNil, Nil}

  monadic_switch NonNil, Nil
end
