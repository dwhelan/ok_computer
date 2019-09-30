defmodule OkComputer.Truthy do
  import OkComputer.Switch
  alias OkComputer.Monad.{Truthy, Falsey}

  monadic_switch(Truthy, Falsey)
end
