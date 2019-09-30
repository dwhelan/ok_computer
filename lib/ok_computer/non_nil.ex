defmodule OkComputer.NonNil do
  import OkComputer.Switch
  alias OkComputer.Monad.{NonNil, Nil}

  @spec monadic_switch(nil, nil) :: Macro.t()
  monadic_switch(NonNil, Nil)
end
