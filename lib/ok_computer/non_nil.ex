defmodule OkComputer.NonNil do
  alias OkComputer.Monad.{NonNil, Nil}

  import OkComputer.Switch

  monadic_switch(NonNil, Nil)
end
