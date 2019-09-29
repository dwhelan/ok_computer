defmodule OkComputer.NonNil do
  import OkComputer.Switch
  alias OkComputer.Monad.{NonNil, Nil}

  monadic_switch NonNil, Nil
end
